# What's the bug?

In the mangopay sandbox, when creating a web payin, the returned payline URL returns an empty page when immediately requested. A 5-second sleep seems to be ok.


# Dependencies

* ruby (> 1.9.3)


# How to run

```
git clone https://github.com/MrRuru/mangopay-sandbox-bug-reproduction.git
cd mangopay-sandbox-bug-reproduction.git
./run.sh
```
