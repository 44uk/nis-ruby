require 'nis/version'
require 'nis/mixin'
require 'nis/util'
require 'nis/client'
require 'nis/endpoint'
require 'nis/struct'
require 'nis/transaction'
require 'nis/unit'
require 'nis/error'

# API Ruby Wrapper for NEM Infrastructure Server
class Nis
  extend Forwardable

  def_delegators :@client, :request, :request!

  # @param [hash] options HTTP Client connection information
  # @option options [Symbol] :url URL
  # @option options [Symbol] :scheme default http (http only)
  # @option options [Symbol] :host default 127.0.0.1
  # @option options [Symbol] :port default 7890
  # @option options [Symbol] :timeout default 5
  def initialize(options = {})
    @client = Client.new(options)
  end

  include Nis::Endpoint::Heartbeat
  include Nis::Endpoint::Status
  include Nis::Endpoint::Shutdown

  include Nis::Endpoint::Account::Generate
  include Nis::Endpoint::Account::Get
  include Nis::Endpoint::Account::Status
  include Nis::Endpoint::Account::Transfers
  include Nis::Endpoint::Account::UnconfirmedTransactions
  include Nis::Endpoint::Account::Harvests
  include Nis::Endpoint::Account::Importances
  include Nis::Endpoint::Account::Namespace
  include Nis::Endpoint::Account::Mosaic
  include Nis::Endpoint::Account::Unlock
  include Nis::Endpoint::Account::Lock
  include Nis::Endpoint::Account::Unlocked
  include Nis::Endpoint::Account::Historical

  include Nis::Endpoint::Chain::Height
  include Nis::Endpoint::Chain::LastBlock
  include Nis::Endpoint::Chain::Score

  include Nis::Endpoint::Namespace
  include Nis::Endpoint::Namespace::Mosaic
  include Nis::Endpoint::Namespace::Root

  include Nis::Endpoint::Block::At
  include Nis::Endpoint::Block::Get

  include Nis::Endpoint::Transaction::PrepareAnnounce
  include Nis::Endpoint::Transaction::Announce

  include Nis::Endpoint::Local::Account::Transfers
  include Nis::Endpoint::Local::Chain

  include Nis::Endpoint::Node::ActivePeers
  include Nis::Endpoint::Node::Boot
  include Nis::Endpoint::Node::Experiences
  include Nis::Endpoint::Node::ExtendedInfo
  include Nis::Endpoint::Node::Info
  include Nis::Endpoint::Node::PeerList

  include Nis::Endpoint::Debug::Connections
  include Nis::Endpoint::Debug::TimeSynchronization
end
