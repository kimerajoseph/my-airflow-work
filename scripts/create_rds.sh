#!/usr/bin/env bash

aws rds create-db-instance \
    --db-instance-identifier airflow-postgres \
    --db-name airflow \
    --allocated-storage 22 \
    --db-instance-class db.t3.micro \
    --engine postgres \
    --master-username airflowadmin \
    --master-user-password supersecretpassword \
    --no-publicly-accessible \
    --region eu-west-3 \


# [--db-security-groups <value>]
# [--vpc-security-group-ids <value>]
# [--availability-zone <value>]
# [--region <value>]
# [--version <value>]
# [--port <value>]

# [--db-subnet-group-name <value>]
# [--preferred-maintenance-window <value>]
# [--db-parameter-group-name <value>]
# [--backup-retention-period <value>]
# [--preferred-backup-window <value>]

# [--multi-az | --no-multi-az]
# [--engine-version <value>]
# [--auto-minor-version-upgrade | --no-auto-minor-version-upgrade]
# [--license-model <value>]
# [--iops <value>]
# [--option-group-name <value>]
# [--character-set-name <value>]
# [--nchar-character-set-name <value>]
# [--publicly-accessible | --no-publicly-accessible]
# [--tags <value>]
# [--db-cluster-identifier <value>]
# [--storage-type <value>]
# [--tde-credential-arn <value>]
# [--tde-credential-password <value>]
# [--storage-encrypted | --no-storage-encrypted]
# [--kms-key-id <value>]
# [--domain <value>]
# [--copy-tags-to-snapshot | --no-copy-tags-to-snapshot]
# [--monitoring-interval <value>]
# [--monitoring-role-arn <value>]
# [--domain-iam-role-name <value>]
# [--promotion-tier <value>]
# [--timezone <value>]
# [--enable-iam-database-authentication | --no-enable-iam-database-authentication]
# [--enable-performance-insights | --no-enable-performance-insights]
# [--performance-insights-kms-key-id <value>]
# [--performance-insights-retention-period <value>]
# [--enable-cloudwatch-logs-exports <value>]
# [--processor-features <value>]
# [--deletion-protection | --no-deletion-protection]
# [--max-allocated-storage <value>]
# [--enable-customer-owned-ip | --no-enable-customer-owned-ip]
# [--custom-iam-instance-profile <value>]
# [--backup-target <value>]
# [--network-type <value>]
# [--storage-throughput <value>]
# [--cli-input-json <value>]
# [--generate-cli-skeleton <value>]
# [--debug]
# [--endpoint-url <value>]
# [--no-verify-ssl]
# [--no-paginate]
# [--output <value>]
# [--query <value>]
# [--profile <value>]
