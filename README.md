<p align="center">
  <a href="" rel="noopener">
 <img width=200px height=200px src="https://imgur.com/qACS8rr.png" alt="Project logo"></a>
</p>

<h3 align="center">Set Default Homepage Policy for Microsoft Edge & Google Chrome</h3>

<div align="center">

</div>

---

<p align="center"> 
PowerShell script to enforce a default homepage for Microsoft Edge and Google Chrome using machine-wide registry policies.  
Designed for automation platforms such as NinjaOne. 
<br> 
</p>

## 📝 Table of Contents
- [About](#about)
- [Usage](#usage)
- [Built Using](#built_using)
- [Authors](#authors)
- [Acknowledgments](#acknowledgement)

---

## 🧐 About <a name = "about"></a>
This project enforces a consistent homepage across all devices within PAG by using registry-based browser policies for both Microsoft Edge and Google Chrome.  
It ensures that both Microsoft Edge and Google Chrome open to a specified homepage on startup and display a Home button that leads to the same page.  

The script uses Windows PowerShell to modify **HKLM** registry keys under the **Policies** path, which applies settings to all of the users on that machine. When deployed through automation such as **NinjaOne**, it runs as `SYSTEM` and guarantees the changers once a user logs in. 

---

## 🎈 Usage <a name="usage"></a>

To apply the policy:
1. Deploy the PowerShell script to run automatically via policies
2 The script writes registry policies to:
   - `HKLM\SOFTWARE\Policies\Microsoft\Edge`
   - `HKLM\SOFTWARE\Policies\Google\Chrome`
3. On next launch, both browsers will open to the homepage and display a managed “Home” button.

---

## ⛏️ Built Using <a name = "built_using"></a>
- [PowerShell](https://learn.microsoft.com/en-us/powershell/) – Automation scripting
- [Windows Registry](https://learn.microsoft.com/en-us/windows/win32/sysinfo/registry) – Policy storage

---

## ✍️ Authors <a name = "authors"></a>
- [@RubenMunoz](https://github.com/rubenmunoz7) – Developer & Maintainer  

---

## 🎉 Acknowledgements <a name = "acknowledgement"></a>
- Thanks to **Microsoft** and **Google** for providing detailed documentation on policy registry paths.  
- Tested and validated via **NinjaOne Policy Automation**.
