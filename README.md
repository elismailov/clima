# Clima - Weather App

A simple iOS weather app that fetches weather data from OpenWeatherMap API.

## **Setup Instructions**

Follow these steps to set up and test this project locally:

### **1. Clone the Repository**

First, clone the repository to your local machine:

```bash
git clone https://github.com/elismailov/clima.git
cd clima
```

### **2. Install Xcode**

Ensure you have [Xcode](https://developer.apple.com/xcode/) installed on your system. The project is built for iOS using Xcode, so you will need it to open and run the project.

### **3. Create a `.env` File**

The project uses an `.env` file to store the API key securely. You must create your own `.env` file with your API key from [OpenWeatherMap](https://openweathermap.org/).

#### **Steps:**
1. Go to the [OpenWeatherMap API page](https://openweathermap.org/api) and sign up or log in.
2. Generate your API key by creating a new API account in your OpenWeatherMap dashboard.
3. Create a file named `.env` in the root directory of the project (next to `README.md`).
4. Add your API key to the `.env` file in the following format:

```bash
API_KEY=your_openweathermap_api_key_here
```

Replace `your_openweathermap_api_key_here` with the actual key provided by OpenWeatherMap.

### **4. Open the Project in Xcode**

1. Open `Clima.xcodeproj` in Xcode.
2. Select the appropriate iOS simulator or connect your physical iPhone for testing.

### **5. Run the Project**

1. Build and run the project in Xcode by pressing `Command + R` or clicking the "Run" button.
2. The app should now work with your personal API key.

### **6. Troubleshooting**

- If the app doesn't display weather data, check:
- Your API key in `.env` (ensure it's correct).
- Your internet connection.
- The format of the `.env` file (should not have extra spaces or characters).
- Ensure `.env` is in the same directory as the project files.

# Screenshots

<p align="center">
  <img src="screenshots/light.png" alt="light" style="width: 30%;">
  &nbsp;
  <img src="screenshots/dark.png" alt="dark" style="width: 30%;">
</p>