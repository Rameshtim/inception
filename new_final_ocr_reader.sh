#!/usr/bin/env python3

import cv2
import pytesseract
import os
import tkinter as tk
from tkinter import filedialog, messagebox, ttk
import unicodedata
import csv
from concurrent.futures import ThreadPoolExecutor, as_completed
import threading
import re


# to select a path for the data (initialdir is where the program will show first)
def select_folder():
    folder_path = filedialog.askdirectory(initialdir='/media/praktikant/Linux_Volume', title="Bitte Ordner wählen")
    return folder_path

#get the text out of the image
def extract_text(image_path):
#set some settings to process the image better for tesseract
    img = cv2.imread(image_path)
# make the picture in Black and White
    gray_img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    gray_img = cv2.resize(gray_img, None, fx=2, fy=2, interpolation=cv2.INTER_CUBIC)
    gray_img = cv2.GaussianBlur(gray_img, (5, 5), 0)
    thresh = cv2.adaptiveThreshold(
        gray_img, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY_INV, 15, 6
    )
    contours, _ = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

#Make dictionary to save the result read from tesseract
    extracted_text = {'Zug': [], 'Restrictions': []}
#what to look for
    zug_phrases = {"Kleinwagen", "Nebenfahrzeug", "Schienengebundenes"}
    restriction_phrases = {"Darf nicht in Züge eingestellt werden", "Abstoßen und Ablaufen"}

#search through the loop and make a rectangle of text blocks
    for contour in reversed(contours):
        x, y, w, h = cv2.boundingRect(contour)
        #skip the small blocks that are unnecessary
        if w < 300 or h < 30:
            continue
        roi = gray_img[y:y+h, x:x+w]
        #give the settings to read in which block we want in bigger fonts and where we need automatically
        if y < 1000:
            config = '--psm 11'
        else:
            config = '--psm 3'
            #set the language to german
        text = pytesseract.image_to_string(roi, lang='deu', config=config)
        #if we find in Zug block save in Zug dictonary else save in Restrictions
        if any(phrase in text for phrase in zug_phrases):
            extracted_text['Zug'].append(text)
        elif any(phrase in text for phrase in restriction_phrases):
        #for some data it was reading as Bersonenanzahl that we replace with Personenanzahl
            text = re.sub(r'Bersonenanzanhl', 'Personenanzahl', text)
            extracted_text['Restrictions'].append(text)


    return extracted_text

#clean unwanted characters that came from ocr
def clean_text(text):
    cleaned_text = ''.join(
        c for c in text 
        if (unicodedata.category(c) != 'Cc' or c in '\r\n\t')
    )
    return cleaned_text.strip()

def process_image(image_file, image_dir):
    image_path = os.path.join(image_dir, image_file)
    #if the file is bigger than 1 MB skip
    if os.path.getsize(image_path) > 1048576:
        skipped_files.append(image_file)
        return {'Filename': image_file, 'Zug': 'Nicht Bearbeitet', 'Restrictions': 'Nicht Bearbeitet'}
    #get the text out of the selected image
    extracted_text_raw = extract_text(image_path)
    #save the text with key value to save in csv data
    extracted_text_csv = {
        'Filename': image_file,
        'Zug': clean_text(' '.join(extracted_text_raw.get('Zug', []))),
        'Restrictions': clean_text(' '.join(extracted_text_raw.get('Restrictions', []))),
    }

#save the file as text file
    output_text_path = os.path.join(image_dir, os.path.splitext(image_file)[0] + '.txt')
    with open(output_text_path, 'w', encoding='utf-8') as output_file:
        output_file.write(f'Zug:\n{extracted_text_csv["Zug"]}\n\nRestriktionen:\n{extracted_text_csv["Restrictions"]}\n')

#save the file as csv file
    output_csv_path = os.path.join(image_dir, os.path.splitext(image_file)[0] + '.csv')
    with open(output_csv_path, 'w', newline='', encoding='utf-8') as csvfile:
        fieldnames = ['Filename', 'Zug', 'Restrictions']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerow(extracted_text_csv)

    return extracted_text_csv

#to make it look visualy better
def update_progress_bar(value):
    progress_bar['value'] = value
    root.update_idletasks()

#update the progressbar as we start processing the images
def update_progress(message):
    progress_var.set(message)
    root.update_idletasks()

#process defined batch size of images at a time
def process_batch(image_files, image_dir):
    all_texts = []
    #decide how many threads to use
    with ThreadPoolExecutor(max_workers=5) as executor:
        future_to_file = {executor.submit(process_image, image_file, image_dir): image_file for image_file in image_files}
        #join the threads that are completed
        for future in as_completed(future_to_file):
            result = future.result()
            if result:
                all_texts.append(result)
                processed_files = len(all_texts)
                update_progress(f"In Bearbeitung {processed_files}/{len(image_files)} files...")
                update_progress_bar((processed_files / len(image_files)) * 100)
    return all_texts

#also we give 5 images at a time to be processed, so the processing is not queued with all the files at once
def worker_thread(image_dir, image_files):
    total_files = len(image_files)
    batch_size = 5
    all_texts = []
    
    while image_files:
        batch = image_files[:batch_size]
        image_files = image_files[batch_size:]
        results = process_batch(batch, image_dir)
        all_texts.extend(results)
        
        #if no more files are left to process ask if the user wants to save the data from all the images as one csv files
        #if yes save it as combined_output.csv otherwise just quit
        if not image_files:
            save_in_one_file = messagebox.askquestion("Save Combined Output", "Möchtest du alle Text Ergebnisse in einer CSV-Datei speichern?", icon='question')
            if save_in_one_file == 'yes':
                csv_file_path = os.path.join(image_dir, 'combined_output.csv')
                with open(csv_file_path, 'w', newline='', encoding='utf-8') as csvfile:
                    fieldnames = ['Filename', 'Zug', 'Restrictions']
                    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
                    writer.writeheader()
                    for text_data in all_texts:
                        writer.writerow(text_data)
                update_progress(f"Combined output saved to {csv_file_path}")

            if skipped_files:
                skipped_message = "Nicht bearbeitet wegen Größe größer als 1MB:\n" + "\n".join(skipped_files)
                messagebox.showerror("Fehler", skipped_message)

            root.quit()

#made a script to look visually better by creating GUI progress bar
def run_script():
    global root, progress_var, progress_bar, skipped_files
    skipped_files = []

    root = tk.Tk()
    root.title("Processing Images")
    root.geometry("600x400")

    progress_var = tk.StringVar()
    progress_label = tk.Label(root, textvariable=progress_var, wraplength=580)
    progress_label.pack(pady=10, padx=10)
    
    progress_bar = ttk.Progressbar(root, orient='horizontal', length=500, mode='determinate')
    progress_bar.pack(pady=20, padx=20)

    def update_progress(message):
        progress_var.set(message)
        root.update_idletasks()

    def update_progress_bar(value):
        progress_bar['value'] = value
        root.update_idletasks()

    image_dir = select_folder()
    if not image_dir:
        messagebox.showinfo("Info", "No folder selected. Exiting.")
        root.destroy()
        return

    image_files = sorted([f for f in os.listdir(image_dir) if f.endswith('.TIF')])
    update_progress("Wird bearbeitet. Bitte warten...")
    progress_bar['maximum'] = 100

    threading.Thread(target=worker_thread, args=(image_dir, image_files), daemon=True).start()

    root.mainloop()

#this is where the program starts
if __name__ == "__main__":
    run_script()

