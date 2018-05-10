# update sys-devel

## add keywords

`nano -w /etc/portage/package.accept_keywords`

add code

```
=sys-devel/binutils-2.30-r2 amd64
=sys-libs/glibc-2.27-r2 **
=sys-devel/gcc-8.1.0-r1 **
```

## update gcc

```
emerge -uD gcc
```

## update glibc

`emerge -uDq binuntils glibc`
