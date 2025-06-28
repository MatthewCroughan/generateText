# Don't

If you wanted, you can now just ask for C programs like

```nix
{
  hello-pleasedont = pkgs.writeCBin "hello-horror"
    (builtins.readFile
      (pkgs.generateText {
        prompt = "// Below is a desparate attempt to convince the user not to do this in C\n";
        seed = 2;
      })
    );
}
```

# Why

```
$ nix run .#hello-llm
Hello, World!

$ nix run .#hello-banana
Hello banana
```

# If you need to look at the sources before you run this godforsaken thing

```
$ nix build .#hello-llm-sources
$ cat result

// Below is hello world in C

#include <stdio.h>
int main()
{
   printf("Hello, World!\n");
   return 0;
}

$ nix build .#hello-banana-sources

$ cat result
// Below is  hello world in C, but 'world' is replaced with 'banana'


// #include <stdio.h>
// #include <stdlib.h>

// int main()
// {
// 	printf("Hello world\n");
// 	return 0;
// }



#include <stdio.h>
#include <stdlib.h>

int main()
{
	printf("Hello banana\n");
	return 0;
}
```
