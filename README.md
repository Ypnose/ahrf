arht - [a]scii (or [a]wk) [r]eadable [h]uman [t]ext
---------------------------------------------------

arht is an `awk` script designed to interpret a simple and straightforward
ascii file format. I wrote it to share my personal documentation, which is
written in plain text files. The main goal was... readability.

  * One requirement: `awk`
  * Supporting all `awk` variants (`nawk`, `mawk` or `gawk`)
  * Simple syntax
  * Easy to use / remember
  * Compatible with [wswsh](https://github.com/Ypnose/Wswsh)
  * File format can be parsed by almost everything: `sed`, `sh`, `python` or `C`

Syntax
------

`<h1>` to `<h6>`

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

`<p>`

You just need to put your paragraph inside the file. Nothing else is needed:

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

`<pre><code></code></pre>`

WIP!
