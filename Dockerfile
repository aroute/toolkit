FROM centos:latest

RUN yum upgrade -y && yum install -y gettext iputils mlocate git curl which openssl zip unzip java-1.8.0-openjdk java-1.8.0-openjdk-devel && yum clean all -y \
&& updatedb \
&& curl -sL https://ibm.biz/idt-installer | bash \
&& curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
&& chmod 700 get_helm.sh \
&& bash ./get_helm.sh \
&& curl -sLo /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/oc/4.5.0-202005291637.git.1.028909b.el7/linux/oc.tar.gz \
&& tar xzvf /tmp/oc.tar.gz -C /usr/local/bin/ \
&& rm -rf /tmp/oc.tar.gz
&& curl -sLo /tmp/cpd-cli.tar.gz https://github.com/IBM/cpd-cli/releases/download/v3.5.2/cpd-cli-linux-EE-3.5.2.tgz \
&& tar xzvf /tmp/cpd-cli.tar.gz -C /usr/local/bin/ \
&& rm -rf /tmp/cpd-cli.tar.gz

RUN useradd -ms /bin/bash demo
USER demo
WORKDIR /home/demo

ENTRYPOINT ["/bin/bash", "-ce", "tail -f /dev/null"]
