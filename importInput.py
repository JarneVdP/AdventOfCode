import os
import requests

# Get the URL for the input data from the user
url = input("Enter the URL for the input data: ")

# Extract the year and day from the URL eg https://adventofcode.com/2022/day/8 -> 2022, 8
year = url.split("/")[3]
day = url.split("/")[5]

# Create the folder structure based on the year and day https://adventofcode.com/2022/day/8 -> main folder 2022 -> subfolder day8
folder_name = os.path.join(year, f"Day {day}")
os.makedirs(folder_name, exist_ok=True)

# Puzzle inputs differ by user. So export your session ID as an environment variable and use it to authenticate your request
with open("session.txt", "r") as f:
    session_id = f.read().strip()

# Make a GET request to the URL and get the input data
inputurl = f"{url}/input"
response = requests.get(inputurl, headers={"User-Agent": "https://github.com/JarneVdP/AdventOfCode by Jarne"}, cookies={"session": session_id})
input_data = response.text

# Write the input data to a file named day_year.txt in the created folder
# eg 2022/day/8.txt -> 8_22.txt
filename = f"{day}_{year[2:]}.txt"
Julia_filename = f"{day}_{year[2:]}.jl"
with open(os.path.join(folder_name, filename), "w") as f:
    f.write(input_data)
with open(os.path.join(folder_name, Julia_filename), "w") as f:
    f.write("")
with open(os.path.join(folder_name, "test.txt"), "w") as f:
    f.write("")