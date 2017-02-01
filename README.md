
# MarkEdit 

a very simple Oh-My-ZSH Plugin to mark Files and Edit them 

## INSTALATION

```sh
git clone https://github.com/zakariaGatter/MarkEdit ~/.oh-my-zsh/custom/plugins/markedit
```

### Add MarkEdit Plugin to ~.zshrc

---

```sh
plugins=(... markedit ... )
```

#### Usage

---

* [X] : **Add Mark**

``` sh
editadd makedit ~/.oh-my-zsh/custom/plugins/markedit/markedit.plugin.zsh
```
Or if the File need Sudo Permition 
``` sh 
editadd sudo markedit ~/.oh-my-zsh/custom/plugins/markedit/markedit.plugin.zsh
```

* [X] : **Remove Mark**
```sh
editdel markedit
```

* [X] : **Edit Mark**
```sh
editmark markedit
```

* [X] : **Show Marks**
 ```sh
editshow
 ```

### Settings

---

To Specific **MarkEdit** Config File Add this line to your ```~/.zshrc```

> MARKEDIT_FILE="Name_of_file"

default Config File 

* MARKEDIT_FILE="mark\_edit"

``` Config file will always be in this PATH "~/.$MARKEDIT_FILE"```

> Default editor is Your `$EDITOR`

### [!] Notes

If You Found any issues or have new ideos please send me a mail to :

**Gmail :**

``` sh
zakaria.gatter@gmail.com
```
