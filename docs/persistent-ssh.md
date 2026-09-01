### Keep `ssh-agent` running across logins

**Initial setup + verification**
- Ensure lingering is enabled so your per-user systemd keeps running after logout: `sudo loginctl enable-linger $USER`; confirm with `loginctl show-user $USER | grep Linger`.
- Create directories if missing: `mkdir -p ~/.config/systemd/user ~/.ssh`.
- Add a user service file `~/.config/systemd/user/ssh-agent.service` with something like:
  ```
  [Unit]
  Description=SSH key agent

  [Service]
  Type=simple
  Environment=SSH_AUTH_SOCK=%t/ssh-agent.socket
  ExecStart=/usr/bin/ssh-agent -D -a $SSH_AUTH_SOCK

  [Install]
  WantedBy=default.target
  ```
  This runs one agent per user session, exposing a stable socket in `%t` (usually `/run/user/$UID`).
- Reload your user systemd and enable the service: `systemctl --user daemon-reload` then `systemctl --user enable --now ssh-agent.service`. Verify with `systemctl --user status ssh-agent`.
- Export the socket path on login. Add to `~/.bashrc`/`~/.zshrc`:
  ```
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
  ```
  Open a new shell or run `source ~/.zshrc`, then check `echo $SSH_AUTH_SOCK` points to the socket and `ssh-add -l` returns “The agent has no identities.”
- Add your key once per boot: `ssh-add ~/.ssh/id_ed25519` (or whichever key). Confirm with `ssh-add -l`. Because the agent is now a persistent service, the identity survives across SSH logins until the machine reboots or the service restarts.

**After a reboot**
- On reconnect, confirm the agent service is running: `systemctl --user status ssh-agent` and `echo $SSH_AUTH_SOCK`.
- If lingering was disabled or the service is inactive, rerun `sudo loginctl enable-linger $USER` and `systemctl --user enable --now ssh-agent`.
- Re-add your key (passphrase prompted once): `ssh-add ~/.ssh/id_ed25519`; verify with `ssh-add -l`.
- Optionally script the post-reboot step by putting `ssh-add` in a protected script you call manually, or use a tool like `ssh-askpass` for deferred prompts if you ever connect without TTY.

With this setup, you only type your key passphrase once per server boot, yet every SSH session attaches automatically to the same agent socket.
