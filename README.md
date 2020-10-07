# tv-static

Generate random images similar to the static from old analog television screens.

Supports multiple colours, with black and white always included. Use the command line to specify the width, height, and additional RGB values.

## Installation

```bash
git clone https://github.com/mel-brown/tv-static
cd tv-static
stack build
```

## Usage

You can specify the width and height as optional arguments, i.e. `stack run -- w h` using positive integer values for `w` and `h`.

```bash
stack run -- 64 64
> Add another colour? (y/n): y
> Red:   255
> Green: 0
> Blue:  127
> Add another colour? (y/n): n
> Saved as 'tvstatic.png'
```