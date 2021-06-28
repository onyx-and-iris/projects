# encoding: utf-8

##
# Backup Generated: teamspeak_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t teamspeak_backup [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://backup.github.io/backup
#
Model.new(:teamspeak_backup, 'Routinely backup the teamspeak database') do
    split_into_chunks_of 250
    compress_with Gzip

    ##
    # MySQL [Database]
    ##
    database MySQL do |db|
        db.name = "<db name>"
        db.username = "<username>"
        db.password = "<password>"
        db.host = "<ip>"
        db.port = <port>
        db.additional_options = ["--quick", "--single-transaction"]
        db.prepare_backup = true
    end

    store_with Local do |local|
        local.path = "</path/to/backups>"
        local.keep = 20
    end
end
