# Copyright 2014 Joukou Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
FROM quay.io/joukou/nginx
MAINTAINER Isaac Johnston <isaac.johnston@joukou.com>

ENV GRAFANA_VERSION 1.7.0

# Install Grafana
RUN wget http://grafanarel.s3.amazonaws.com/grafana-${GRAFANA_VERSION}.tar.gz -O grafana.tar.gz
RUN tar zxf grafana.tar.gz && rm grafana.tar.gz && mv grafana-${GRAFANA_VERSION} /var/www

# Add configuration files
ADD config.js /var/www/config.js
ADD etc/nginx/sites-available/grafana.joukou.com /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/grafana.joukou.com /etc/nginx/sites-enabled/

# Expose ports
#   8080 intra-cluster  HTTP
EXPOSE 8080

# Execute systemd by default
CMD [ "/bin/systemd-init" ]