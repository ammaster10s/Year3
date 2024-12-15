from PyPDF2 import PdfMerger

def merge_pdfs(pdf_list, output_filename):
    """
    Merges multiple PDF files into a single PDF.

    Args:
        pdf_list (list): List of PDF file paths to merge.
        output_filename (str): Path to the output merged PDF file.
    """
    merger = PdfMerger()

    try:
        for pdf in pdf_list:
            merger.append(pdf)
            print(f"Added: {pdf}")
        
        merger.write(output_filename)
        print(f"Merged PDF saved as: {output_filename}")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        merger.close()

# Example usage:
if __name__ == "__main__":
    # List of PDF files to merge
    pdf_files = ["/Users/ammaster10/Documents/SIIT/Me/PawarisPanyasombat_CV.pdf", "'/Users/ammaster10/Downloads/Green And White Travel And Tour Flyer.pdf'"]  
    # Output merged PDF file
    output_file = "merged.pdf"  
    
    merge_pdfs(pdf_files, output_file)
