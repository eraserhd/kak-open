#!/usr/bin/env bash
source test/functions.bash

h2 '"existing" method'
  #t 'fails if file not open in a client' -fails
  #t 'focuses first client in which file is open'
  #t 'jumps to the specified line'

h2 '"jumpclient" method'
  t 'fails if jumpclient is empty' -set jumpclient='' -fails
  #t 'opens in jumpclient if set' -set jumpclient=c1 -client c1
  #t 'fails if specified jumpclient does not exist' -set jumpclient=bad -fails

h2 'falling back'
  #t 'executes first method, if possible' -methods existing,jumpclient
  #t 'uses second method if first fails' -methods exisitng,jumpclient
  #t 'fails if all methods fail' -fails

summarize
