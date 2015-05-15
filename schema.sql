CREATE TABLE inode (
	id BIGSERIAL,
	size BIGINT DEFAULT 0,
	mode INTEGER NOT NULL DEFAULT 0,
	uid INTEGER NOT NULL DEFAULT 0,
	gid INTEGER NOT NULL DEFAULT 0,
	ctime TIMESTAMP,
	mtime TIMESTAMP,
	atime TIMESTAMP,
	PRIMARY KEY( id )
);

CREATE TABLE dir (
	id BIGSERIAL,
	parent_id BIGINT,
	name TEXT,
	inode_id BIGSERIAL,
	PRIMARY KEY( id ),
	FOREIGN KEY( inode_id ) REFERENCES inode( id ),
	UNIQUE( name, parent_id )
);

-- TODO: 4096 is STANDARD_BLOCK_SIZE in config.h, must be in sync!
CREATE TABLE data (
	inode_id BIGINT,
	block_no BIGINT NOT NULL DEFAULT 0,
	data BYTEA,
	PRIMARY KEY( inode_id, block_no ),
	FOREIGN KEY( inode_id ) REFERENCES inode( id )
);

-- create indexes for fast data access
CREATE INDEX data_inode_id_idx ON data( inode_id );
CREATE INDEX data_block_no_idx ON data( block_no );

-- create an index on the parent_id for
-- directory listings
CREATE INDEX dir_parent_id_idx ON dir( parent_id );

-- 16384 == S_IFDIR (S_IFDIR)
-- TODO: should be created by the program after checking the OS
-- it is running on (for full POSIX compatibility)

-- garbage collect deleted inode entries, delete all blocks in 'data'
CREATE OR REPLACE RULE "inode_remove" AS ON
	DELETE TO inode WHERE OLD.mode & 16384 = 0
	DO ALSO DELETE FROM data WHERE inode_id=OLD.id;	
	
-- self-referencing anchor for root directory
-- 16895 = S_IFDIR and 0777 permissions, belonging to root/root
-- TODO: should be done from outside, see note above
INSERT INTO inode( id, size, mode, uid, gid, ctime, mtime, atime )
	VALUES( 0, 0, 16895, 0, 0, NOW( ), NOW( ), NOW( ) );
INSERT INTO dir( id, parent_id, name, inode_id )
	VALUES( 0, 0, '/', 0 );
