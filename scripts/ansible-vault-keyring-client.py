#!/usr/bin/env python

import argparse
import keyring
import getpass
import sys

keyring_system = 'ansible'

def main():
  parser = argparse.ArgumentParser(description=
    '''
    Provide ansible vault passwords from the gnome keyring.
    ''',
  )

  parser.add_argument('action',
    nargs='?',
    default=None,
    help='''
    `add`: Add a password to the keyring.
    `del`: Delete a password from the keyring.
    If action is omitted, the a password will be printed to stdout
    as expected by an ansible vault password script.
    Provide a vault ID with `--vault-id`.
    '''
  )

  parser.add_argument('--vault-id',
    default='default',
    dest='id',
    help='Specify vault ID linked to the password (default: `%(default)s`).'
  )

  args = parser.parse_args()

  if args.action == 'add':
    add_password(args.id)
    return
  elif args.action == 'del':
    delete_password(args.id)
    return

  pw = get_password(args.id)
  if pw == None:
    sys.exit('No password stored for `' + args.id + '`.')
  else:
    print(pw)
  
def add_password(id):
  if password_exists(id):
    if get_user_consent('overwrite', id):
      force_delete_password(id)
    else:
      print('Adding new password aborted.')
      return

  keyring.set_password(keyring_system, id, password())
    
  print_success_message('added', id)

def password_exists(id):
  return get_password(id) != None

def get_password(id):
  return keyring.get_password(keyring_system, id)
  
def get_user_consent(action, id):
  msg = 'Do you want to ' + action + ' the password for the vault ID `' + id 
  msg += '` (yes, no)?'
  consent = input(msg)
  return consent == 'yes'

def force_delete_password(id):
  keyring.delete_password(keyring_system, id)

def print_success_message(action, id):
  print('SUCCESS: Password ' + action + ' to the keyring.')
  print('    service: ' + keyring_system)
  print('    id:      ' + id)

def delete_password(id):
  if not password_exists(id):
    sys.exit('ERROR: No password found for the ID `' + id + '`.')
  
  if not get_user_consent('delete', id):
    print('Deleting new password aborted.')
    return
  
  force_delete_password(id)

def password():
  return getpass.getpass()

if __name__ == '__main__':
  main()
