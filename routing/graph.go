package routing

import (
	"time"
	"github.com/boltdb/bolt"
	"github.com/roasbeef/btcd/btcec"
	"github.com/roasbeef/btcd/wire"
	"github.com/lightningnetwork/lnd/channeldb"
	"github.com/roasbeef/btcd/chaincfg/chainhash"
)

// TODO(roasbeef): abstract out graph to interface
//  * add in-memory version of graph for tests


type Graph interface {

	ForEachChannel(cb func(*channeldb.ChannelEdgeInfo, *channeldb.ChannelEdgePolicy, *channeldb.ChannelEdgePolicy) error) error
	ForEachNode(tx *bolt.Tx, cb func(*bolt.Tx, *channeldb.LightningNode) error) error
	SourceNode() (*channeldb.LightningNode, error)
	SetSourceNode(node *channeldb.LightningNode) error
	AddLightningNode(node *channeldb.LightningNode) error
	LookupAlias(pub *btcec.PublicKey) (string, error)
	DeleteLightningNode(nodePub *btcec.PublicKey) error
	AddChannelEdge(edge *channeldb.ChannelEdgeInfo) error
	HasChannelEdge(chanID uint64) (time.Time, time.Time, bool, error)
	UpdateChannelEdge(edge *channeldb.ChannelEdgeInfo) error
	PruneGraph(spentOutputs []*wire.OutPoint, blockHash *chainhash.Hash, blockHeight uint32) ([]*channeldb.ChannelEdgeInfo, error)
	DisconnectBlockAtHeight(height uint32) ([]*channeldb.ChannelEdgeInfo, error)
	PruneTip() (*chainhash.Hash, uint32, error)
	DeleteChannelEdge(chanPoint *wire.OutPoint) error
	ChannelID(chanPoint *wire.OutPoint) (uint64, error)
	UpdateEdgePolicy(edge *channeldb.ChannelEdgePolicy) error
	FetchLightningNode(pub *btcec.PublicKey) (*channeldb.LightningNode, error)
	HasLightningNode(pub *btcec.PublicKey) (time.Time, bool, error)
	FetchChannelEdgesByOutpoint(op *wire.OutPoint) (*channeldb.ChannelEdgeInfo, *channeldb.ChannelEdgePolicy, *channeldb.ChannelEdgePolicy, error)
	FetchChannelEdgesByID(chanID uint64) (*channeldb.ChannelEdgeInfo, *channeldb.ChannelEdgePolicy, *channeldb.ChannelEdgePolicy, error)
	ChannelView() ([]wire.OutPoint, error)
	NewChannelEdgePolicy() *channeldb.ChannelEdgePolicy
	Database() *channeldb.DB

}