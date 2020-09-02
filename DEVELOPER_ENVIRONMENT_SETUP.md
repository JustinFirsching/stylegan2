### 0. I'M ASSUMING YOU CAN ALREADY USE SSH
(Or that you're capable of researching the topic on your own)

<hr>
<br>

### 1. INSTALL VS CODE IF YOU DON'T HAVE IT
https://code.visualstudio.com/Download

<hr>
<br>

### 2. PERFORM THE INSTALL STEPS FOR THE REMOTE SSH EXTENSION
    https://code.visualstudio.com/docs/remote/ssh#_installation

<hr>
<br>

### 3. CONFIGURE THE VS CODE REMOTE SSH EXTENSION
- Open the VS Code Command Palette:
```
View > Command Palette (or CTRL + SHIFT + P)
```

- In Command Palette, scroll down to find ```Remote-SSH: Connect to Host``` and click it.

- Enter the SSH command to use to connect (with no password switch) (one time setup)
```
ssh -p 2222 <USER_NAME>@<REMOTE_HOST>
```
<hr>
<br>

### 4. USING THE REMOTE SSH EXTENSION
- Open ```Command Palette``` again 
- Select ```Remote SSH``` and then the host you configured previously
- A new VS Code window will open. You'll be prompted for your password (if not using an SSH key [**best practices say you should be**])

- Still in the new VS Code window, you can open a folder on the remote machine to edit code that is located there (such as a clone of stylegan2).

<hr>
<br>

### 5. WHY?
- Our intent is to expose a READ/WRITE volume to a docker container containing our code.
- That will allow us edit code, and have those changes instantly visible in said container.
- Since our ```docker run <ET CETERA>``` command will get us an interactive BASH session in the running container: 
    - That means we can easily ```ALT+TAB``` between VS-Code (which should be editing the files on the remote host) and a terminal-based SSH session (which is running inside a container on the remote host but has visibility to the files we're editing on the remote host) for the purpose of running the code we're editing.

<hr>
<br>


### 6. YOUR WORKFLOW COULD BE:
0. Edit code (which is located on <REMOTE_HOST>)
0. Save code
0. ```ALT+TAB```(Or ```CTRL+ ` ``` to switch from VSCode's editor to terminal) to a terminal-based SSH session on <REMOTE_HOST> 
0. Press ```UP-ARROW, ENTER``` to re-run some code 
    - ```python3 <ABS_OR_REL_PATH>/do_stuff.py```
    
<hr>
<br>

### BONUS - SSH KEY SETUP 
(Assumes you have a Unix-like terminal or PuTTY [**Not Windows CMD or Windows Powershell**])
- Open a a terminal on your local machine
- Run ```ssh-keygen``` and select options as desired
- Copy the public key to the server (assuming you used default ```ssh-keygen``` options)
```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub <USER_NAME>@<REMOTE_HOST>:<PORT>
```


