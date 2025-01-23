# hugging-face-demo
MLOps Learn
Here’s a simplified breakdown of Noah Gift's workflow for building and deploying a Hugging Face MLOps application with GitHub Actions:

### Note: look the concept in coursera and practice

# Step 1: Set Up Hugging Face

### Create a Hugging Face Account:
    
    -> Go to Hugging Face and create an account.

    -> Generate an Access Token: Go to your profile → Settings → Access Tokens → Create a new token (read-and-write access).

### Understand Hugging Face Spaces:

    -> Spaces allow you to host machine learning applications.
    
    -> Navigate to Spaces → Create a new space:  
    
         - Name it (e.g., demo2).

         - Select gradio as the hosting technology.

         - Click Create Space.
# Step 2: Set Up GitHub Repository

### Create a New Repository:

    -> Go to GitHub, create a new repository (e.g., hugging-face-demo2), and add:

        - A README.md file.
        - A .gitignore file for Python.

### Use GitHub Codespaces:

    -> Open your repository → Code → Launch a Codespace.
     
    -> Choose a powerful machine (e.g., 16-core, 32GB RAM) for development.

# Step 3: Scaffold the Project

### 1. Set Up the Environment:

Create a Python virtual environment:

```
python -m venv .venv
source .venv/bin/activate
```
Add the virtual environment activation command to .bashrc for auto-activation:

```
echo "source $(pwd)/.venv/bin/activate" >> ~/.bashrc
```

### 2. Add Project Files:

Create the following files:

`requirements.txt:` List dependencies.

```
gradio
transformers
tensorflow
```

`Makefile:` Automate common tasks. 

```
install:
    pip install -r requirements.txt
```

`app.py:` Contains the Gradio-based application.

### 3. Write the Application Code:

Example for a text summarizer
```
import gradio as gr
from transformers import pipeline

summarizer = pipeline("summarization")

def predict(text):
    return summarizer(text)[0]['summary_text']

demo = gr.Interface(fn=predict, inputs="textbox", outputs="textbox")
demo.launch()

```

# Step 4: Automate Deployment with GitHub Actions

### 1. Set Up Repository Secrets:

    - Go to GitHub → Repository → Settings → Secrets → Actions.
    
    - Add a secret named HUGGING_FACE_TOKEN and paste your Hugging Face access token.

### 2. Create a GitHub Actions Workflow:

Add a file ```.github/workflows/main.yml```:

```
name: Deploy to Hugging Face

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: 3.9

      - name: Install dependencies
        run: pip install -r requirements.txt

      - name: Deploy to Hugging Face
        env:
          HF_TOKEN: ${{ secrets.HUGGING_FACE_TOKEN }}
        run: |
          git remote add space https://huggingface.co/spaces/<your-username>/<your-space-name>.git
          git push space main
```

# Step 5: Deploy and Test

### 1. Push Code to GitHub:
  
        - Commit and push your project to the repository.
   
        - The GitHub Actions workflow will automatically deploy it to Hugging Face Spaces.

### 2. Access the Deployed App:

    - Go to your Hugging Face profile → Spaces → Select your space (e.g., demo2).

    - Test the application by entering text and observing the summarized output.

# Key Points

`Gradio` provides an intuitive interface for machine learning applications.

`GitHub Actions` handles automated deployment.

`Hugging Face Spaces` is a powerful platform for hosting and sharing ML apps.

This end-to-end solution showcases how to streamline MLOps workflows!
