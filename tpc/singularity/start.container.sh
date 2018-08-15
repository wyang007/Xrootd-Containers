#!/bin/sh

# export PSS_ORIGIN=atlrdr1:11094
# C7 image seems the RFC compliant proxy 
site=$1

#export XRD_LOGLEVEL=Dump
#export XrdSecDEBUG=1

# Note XROOTD_RDR is the host name (with DNS domain strings) of the redirector, 
# e.g. hostname -f

if [ "$site" = "slac" ]; then # a proxy cluster
    export XROOTD_RDR="griddev03.slac.stanford.edu"
    export PSS_ORIGIN="atlrdr1.slac.stanford.edu:11094"
    export XRD_PORT="2094"
elif [ "$site" = "nersc" ]; then # a single proxy
    export PSS_ORIGIN="dtn02.nersc.gov:1094"
    export XRD_PORT="10940"
fi

singularity run -B /etc/grid-security/certificates \
                -B /etc/grid-security/vomsdir \
                -B /etc/grid-security/xrd/xrdcert.pem \
                -B /etc/grid-security/xrd/xrdkey.pem \
                -B /tmp/x509up_u`id -u`:/var/run/x509up \
            /afs/slac/u/sf/yangw/xrd/tpc/xrdtpc.img
#                -B /tmp/xrootd.cfg:/etc/xrootd/xrootd.cfg \
