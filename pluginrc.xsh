import os, socket, getpass, time

def bar():
  BARBG='{BACKGROUND_#181818}'
  BARFG='{#AAA}'
  PILLBG='{BACKGROUND_#333}'
  PILLFG='{#CCC}'
  LIGHTGREY='{BOLD_#DDD}'
  NOC='{NO_COLOR}'

  ts = os.get_terminal_size()
  cols = ts.columns
  pwd = os.getcwd()
  current_time = time.localtime()
  date = time.strftime('%y-%m-%d %H:%M:%S%z', current_time)
  hst = socket.gethostname()
  usr = getpass.getuser()
  
  pills = {
    'conda_env': str($CONDA_DEFAULT_ENV if 'CONDA_DEFAULT_ENV' in ${...} and $CONDA_DEFAULT_ENV != 'base' else '')
  }
  
  pillst = ""
  pillsc = ""
  pills_cnt = 0
  for p,t in pills.items():
    if t:
      pills_cnt+=1
      pillst += '%s ' % t
      pillsc += '{PILLBG}{PILLFG} %s {NOC}{BARBG}{BARFG} ' % t
  
  lp="{hst} {usr} {pwd}".format(pwd=pwd, hst=hst, usr=usr)
  rp="{pillst} {date}".format(date=date, pillst=pillst)

  lpc="{hst} {usr} {LIGHTGREY}{pwd}{NOC}".format(pwd=pwd, hst=hst, usr=usr, LIGHTGREY=LIGHTGREY, NOC=NOC)
  rpc=("%s{BARBG}{BARFG} {date}" % pillsc).format(date=date, BARBG=BARBG, BARFG=BARFG, PILLBG=PILLBG, PILLFG=PILLFG, NOC=NOC)

  wlen = int(cols) - len(lp) - len(rp) - 3*pills_cnt + (pills_cnt if pills_cnt > 0 else 0)
  w = ' '*wlen
  bar = '{lpc}{BARBG}{BARFG}{w}{rpc}'.format(lpc=lpc, w=w, rpc=rpc, BARBG=BARBG, BARFG=BARFG)
  return '%s%s%s{NO_COLOR}' % (BARBG, BARFG, bar)


$PROMPT_FIELDS['bar'] = bar
$PROMPT="\n{bar}\n{WHITE}{prompt_end}{NO_COLOR} "

$XONSH_COLOR_STYLE="paraiso-dark"

# $COMPLETIONS_CONFIRM=True
