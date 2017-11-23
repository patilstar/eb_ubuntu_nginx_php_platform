#!/usr/bin/env bash
#==============================================================================
# Copyright 2014 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Amazon Software License (the "License"). You may not use
# this file except in compliance with the License. A copy of the License is
# located at
#
#       https://aws.amazon.com/asl/
#
# or in the "license" file accompanying this file. This file is distributed on
# an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, express or
# implied. See the License for the specific language governing permissions
# and limitations under the License.
#==============================================================================

set -xe

SUPPORT_PATH=/opt/elasticbeanstalk/support
/opt/elasticbeanstalk/support/export_envvars
ln -sf $SUPPORT_PATH/envvars /etc/profile.d/eb_envvars.sh
. /opt/elasticbeanstalk/support/envvars
service php7.1-fpm restart
service nginx restart
