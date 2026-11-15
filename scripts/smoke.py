#!/usr/bin/env python3
"""Stateless rendering workflow; no application volume exists or is invented."""
import base64, json, os, urllib.error, urllib.request
b=os.environ['BASE_URL'].rstrip('/')
phase=os.environ['SMOKE_PHASE']
assert phase in ('boot','upgrade','redeploy')
user=os.environ['BASIC_AUTH_USER']; password=os.environ['BASIC_AUTH_PASSWORD']
def request(method,path,payload=None,status=200,auth='valid'):
 headers={'Content-Type':'application/json'}
 if auth!='none':
  pw=password if auth=='valid' else 'incorrect-'+password
  headers['Authorization']='Basic '+base64.b64encode((user+':'+pw).encode()).decode()
 req=urllib.request.Request(b+path,method=method,headers=headers,data=None if payload is None else json.dumps(payload).encode())
 try:r=urllib.request.urlopen(req,timeout=90)
 except urllib.error.HTTPError as e:r=e
 with r:raw=r.read();code=r.code
 assert code==status,f'{method} {path} unexpected status {code}'
 return raw
assert json.loads(request('GET','/healthz'))['status']=='pass'
body={'diagram_source':'digraph G { alpha -> beta }','diagram_type':'graphviz','output_format':'svg'}
request('POST','/',body,status=401,auth='none')
request('POST','/',body,status=401,auth='invalid')
svg=request('POST','/',body).decode()
assert '<svg' in svg and '>alpha<' in svg and '>beta<' in svg
request('POST','/',{**body,'diagram_type':'not-a-renderer'},status=400)
request('POST','/',{**body,'diagram_type':'mermaid','diagram_source':'graph TD; A-->B'},status=503)
print(json.dumps({'phase':phase,'ok':True,'scope':'stateless authenticated graphviz rendering, bad credentials and invalid renderer, documented optional renderer unavailable'}))
