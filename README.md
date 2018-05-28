
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
        ee          change or Edit Exist Mark 

EXAMPLE :  
        ea bashrc ~/.bashrc     ( add 'bashrc' Mark with out sudo Permision )
        ea _ bashrc ~/.bashrc   ( add 'bashrc' Mark with sudo Permision )
        em bashrc               ( Edit to 'bashrc' Mark)
        er bashrc ...           ( Remove 'bashrc' Mark and suport multi Delete)
        ee bashrc               (Edit Exist mark like change the mark name or File) 

File    :   FILE_GATE="~/.config/file-gate"
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

* [X] : **Change Mark Name or File**
```sh
ee markedit
```

### Support 

    * [Fiverr](https://www.fiverr.com/zakariagatter)
    * [Donate](https://www.paypal.me/ZGatter)


### Notes

If You Found any issues or have new ideos please send me a mail to :

**Gmail :**

``` sh
zakaria.gatter@gmail.com
```

#### You may like 

 * [Powergate Theme](https://github.com/zakariaGatter/Powergate)
 * [MarkGate](https://github.com/zakariaGatter/MarkGate)
 * [i3blocks-Gate](https://github.com/zakariaGatter/i3blocks-gate)
