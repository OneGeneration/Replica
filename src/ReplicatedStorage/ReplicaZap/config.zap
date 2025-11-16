opt remote_scope = "REPLICA_ZAP"
opt server_output = "../../../server_repositories/Replica/Zap/Server.luau"
opt client_output = "./Client.luau"
opt tooling = true
opt tooling_output = "../../../server_repositories/Replica/Zap/Tooling.luau"

type ReplicaId = u8

type Path = string[]

-- Events
event RequestData = {
	from: Client,
	type: Reliable,
	call: SingleSync,
}

event InitialDataRecieved = {
	from: Server,
	type: Reliable,
	call: SingleSync,
}

event Set = {
	from: Server,
	type: Reliable,
	call: SingleAsync,
	data: struct {
		replica_id: ReplicaId,
		path: Path,
		value: unknown,
	},
}

event SetValues = {
	from: Server,
	type: Reliable,
	call: SingleAsync,
	data: struct {
		replica_id: ReplicaId,
		path: Path,
		values: map { [string]: unknown },
	},
}

event TableInsert = {
	from: Server,
	type: Reliable,
	call: SingleAsync,
	data: struct {
		replica_id: ReplicaId,
		path: Path,
		value: unknown,
		index: u32?,
	},
}

event TableRemove = {
	from: Server,
	type: Reliable,
	call: SingleAsync,
	data: struct {
		replica_id: ReplicaId,
		path: Path,
		index: u32,
	},
}

event Write = {
	from: Server,
	type: Reliable,
	call: SingleAsync,
	data: struct {
		replica_id: ReplicaId,
		func_id: unknown,
		params: unknown[],
	},
}

event ServerSignal = {
	from: Server,
	type: Reliable,
	call: SingleAsync,
	data: struct {
		replica_id: ReplicaId,
		params: unknown[],
	},
}

event ClientSignal = {
	from: Client,
	type: Reliable,
	call: SingleAsync,
	data: struct {
		replica_id: ReplicaId,
		params: unknown[],
	},
}

-- I don't need Signals, neither do I need them unreliablily

event Parent = {
	from: Server,
	type: Reliable,
	call: SingleAsync,
	data: struct {
		replica_id: ReplicaId,
		parent_id: ReplicaId,
	},
}

event Create = {
	from: Server,
	type: Reliable,
	call: SingleSync,
	data: struct {
		creation: unknown,
		root_id: ReplicaId?,
	},
}

event Bind = {
	from: Server,
	type: Reliable,
	call: SingleAsync,
	data: struct {
		replica_id: ReplicaId,
	},
}

event Destroy = {
	from: Server,
	type: Reliable,
	call: SingleAsync,
	data: struct {
		replica_id: ReplicaId,
	},
}