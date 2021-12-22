#!/usr/bin/python3

from brownie import NOAHBAY, accounts

def main():
    acct = accounts.at('0x2d54EC30Be0D2583b0d781e10B31905c3c54616d', force=True)
    return acct.deploy(NOAHBAY)
