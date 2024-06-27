##############################################################################
# Copyright 2019 IBM Corp. All Rights Reserved.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
##############################################################################

FROM node:19

RUN groupadd -r user
RUN useradd -r -g user user


# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY app/package*.json ./
RUN npm install

# Bundle app source
COPY app/ .
COPY --chmod=755 app/app.sh app.sh

# Create app directory
RUN mkdir /home/user
WORKDIR /app
RUN chown -R user:user /.[^.]*
#RUN chown -R user:user /home/user

USER user

EXPOSE 8443
CMD bash -c './app.sh'
