#!/bin/bash
# ensure id_rsa and/or id_ed25519 are scp'd into this directory before running

# ensure an ssh agent is available to this session
eval $(ssh-agent -S)

sleep 1

if [ -f ./id_rsa ]; then
  echo "adding rsa private key"
  chmod 600 ./id_rsa
  ssh-add ./id_rsa
  echo "if no errors were shown, rsa private key was added successfully"
  if [ -f ./id_rsa.pub ]; then
    echo "adding rsa public key"
    ssh-add -T ./id_rsa.pub
    echo "rsa public key added"
  fi
fi

if [ -f ./id_ed25519 ]; then
  echo "adding ed25519 private key"
  chmod 600 ./id_ed25519
  ssh-add ./id_ed25519
  echo "if no errors were shown, ed25519 private key was added successfully"
  if [ -f ./id_ed25519.pub ]; then
    echo "adding ed25519 public key"
    ssh-add -T ./id_ed25519.pub
    echo "ed25519 public key added"
  fi
fi

echo "SSH key addition complete"
