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
