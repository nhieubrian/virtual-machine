# xilinx-casper

<pre>
nautilus-ansible % kubectl create -n casper secret generic xilinx-casper-egl-pass \              
  --from-literal=username=xilinx-casper-egl-pass \
  --from-literal=password='somesecret'  
secret/xilinx-casper-egl-pass created
</pre>

Grafana Resources for Casper namespace


https://grafana.nautilus.optiputer.net/d/85a562078cdf77779eaa1add43ccec1e/kubernetes-compute-resources-namespace-pods?orgId=1&refresh=10s&var-datasource=default&var-cluster=&var-namespace=casper&from=1616886192178&to=1616889792178
