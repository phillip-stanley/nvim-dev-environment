# nvim-dev-environment

## Installation

1. Install Docker
2. Clone this repo
3. Build the container

```bash
docker build -t neovim-dev -f docker/Dockerfile .
```

4. Run the container

```bash
docker run -it --rm -v ${pwd}:/root/.config/ nvim-dev-environment
```
