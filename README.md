ahrt - [a]scii (or [a]wk) [h]uman [r]eadable [t]ext
---------------------------------------------------

ahrt is an `awk` script designed to interpret a simple and straightforward
ascii file format. I wrote it to share my personal documentation, which is
written in plain text files. They can be exported to HTML.  
The main goal was... readability.

  * One requirement: `awk`
  * Supporting all `awk` variants (`nawk`, `mawk` or `gawk`)
  * Simple syntax
  * Easy to use / remember
  * Compatible with [wswsh](https://github.com/Ypnose/Wswsh)
  * File format can be parsed by almost everything: `sed`, `sh`, `python` or `C`

Syntax
------

#### Headings: `<h1>` to `<h6>`

```
: My important page title :
```

```
<h1>My important page title</h1>
```

```
:: This is the category title ::
```

```
<h2>This is the category title</h2>
```

and so on...

```
::: ::: for <h3><h3>
:::: :::: for <h4><h4>
::::: ::::: for <h5><h5>
:::::: :::::: for <h6><h6>
```

#### Paragraph: `<p>`

You just need to put your paragraph inside the file. Nothing else is
needed:

```
DTLS memory leak from zero-length fragments (CVE-2014-3507)
OpenSSL DTLS anonymous EC(DH) denial of service (CVE-2014-3510)
Race condition in ssl_parse_serverhello_tlsext (CVE-2014-3509)
OpenSSL TLS protocol downgrade attack (CVE-2014-3511)
```
```
<p>DTLS memory leak from zero-length fragments (CVE-2014-3507)
OpenSSL DTLS anonymous EC(DH) denial of service (CVE-2014-3510)
Race condition in ssl_parse_serverhello_tlsext (CVE-2014-3509)
OpenSSL TLS protocol downgrade attack (CVE-2014-3511)</p>
```

#### Code block: `<pre><code></code></pre>`

```
====
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda5        12G  2.5G  8.6G  23% /
dev             3.9G     0  3.9G   0% /dev
run             4.0G  592K  3.9G   1% /run
tmpfs           4.0G     0  4.0G   0% /dev/shm
====
```

```
<pre><code>Filesystem      Size  Used Avail Use% Mounted on
/dev/sda5        12G  2.5G  8.6G  23% /
dev             3.9G     0  3.9G   0% /dev
run             4.0G  592K  3.9G   1% /run
tmpfs           4.0G     0  4.0G   0% /dev/shm</code></pre>
```

#### Unordered list: `<ul><li></li></ul>`

```
* Eat cooked meat
* Buy french bread
* Peel potatoes
* Drink beers
```

```
<ul>
	<li>Eat cooked meat</li>
	<li>Buy french bread</li>
	<li>Peel potatoes</li>
	<li>Drink beers</li>
</ul>
```

#### Page links: `<ul><a></a></ul>`

The "list" needs to be started by `[0]` or `[1]`. If not, it won't be
matched.

```
[0] https://github.com/
[1] http://netbsd.org/
[2] http://ypnose.org/
[666] http://www.libressl.org/
```

```
<ul>
	<li>[0] <a href="https://github.com/">https://github.com/</a></li>
	<li>[1] <a href="http://netbsd.org/">http://netbsd.org/</a></li>
	<li>[2] <a href="http://ypnose.org/">http://ypnose.org/</a></li>
	<li>[666] <a href="http://www.libressl.org/">http://www.libressl.org/</a></li>
</ul>
```

Regressions?
------------
