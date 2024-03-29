import subprocess

def get_download_link():

    # Define your bash command or script
    bash_command = "/home/ariel/Documents/chess_improments_patterns/src/data/get_link.sh 2023"

    # Open a process
    with subprocess.Popen(bash_command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True) as process:
        # Capture output and errors
        stdout, stderr = process.communicate()

        print("STDOUT:", stdout)
        print("STDERR:", stderr)