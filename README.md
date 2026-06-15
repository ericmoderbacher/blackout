# blackout

A kernel-toggling grid game for [monome norns](https://monome.org/docs/norns/) with a connected grid.

Press a cell on the grid to toggle it and its four orthogonal neighbors (a plus-shaped "kernel").
The goal is to black out the grid by turning every light off.

Status: early sketch (v0.0.1) — playable enough to toggle cells; scoring and win detection are not
yet wired up.

## Run

This is a norns script. Copy the project into `dust/code/blackout` on a norns device (or via
maiden), then select `blackout` from the script menu. A grid must be connected.

## Layout

| Path | What |
|------|------|
| `blackout.lua` | script entry point: screen UI, encoder/key input |
| `lib/board.lua` | grid board model and the toggle/kernel logic |
