
# MarkEdit 

a very simple (zsh / bash) Plugin to mark Files and Edit them With Autocompletion for exist Marks 

[![asciicast](https://asciinema.org/a/cHg8JbsNiO66WHlwd8hmAOKll.png)](https://asciinema.org/a/cHg8JbsNiO66WHlwd8hmAOKll)

## INSTALATION

```sh
git clone https://github.com/zakariaGatter/MarkEdit /path/to/markedit
```

### Add MarkEdit Plugin to ~.zshrc

---

```sh
source /path/to/markedit/markedit
```

#### HELP

```
    MARK EDIT (20-05-2018)
    Written by Zakaria Barkouk (zakaria.gatter@gmail.com)

    Mark your file To easy Access

OPTS :       
        ea          Add Mark File
        er          Remove Mark File
        es          Show All Mark File's
        em          Edit Mark File 

EXAMPLE :  
        ea bashrc ~/.bashrc     ( add 'bashrc' Mark with out sudo Permision )
        ea _ bashrc ~/.bashrc   ( add 'bashrc' Mark with sudo Permision )
        em bashrc               ( Edit to 'bashrc' Mark)
        er bashrc ...           ( Remove 'bashrc' Mark and suport multi Delete)

File    :   FILE_GATE=~/.config/file-gate
```

#### Usage

---

* [X] : **Add Mark**

``` sh
ea makedit /path/to/markedit/markedit
```
Or if the File need Sudo Permition 
``` sh 
ea _ markedit /path/to/markedit/markedit.plugin.zsh
```

* [X] : **Remove Mark**
```sh
er markedit
```

* [X] : **Edit Mark**
```sh
em markedit
```

* [X] : **Show Marks**
```sh
es
markedit        /path/to/markedit/markedit # Mark with out sudo permition 
_markedit       /path/to/markedit/markedit # mark with sudo permition 
```


### [!] Notes

If You Found any issues or have new ideos please send me a mail to :

**Gmail :**

``` sh
zakaria.gatter@gmail.com
```
