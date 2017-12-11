require 'nis'
Nis.logger.level = Logger::DEBUG

A_PRIVATE_KEY = '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214'

nis = Nis.new

nis.account_lock(private_key: A_PRIVATE_KEY)
