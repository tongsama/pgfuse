ALTER TABLE dir RENAME TO inode;
ALTER INDEX dir_pkey RENAME TO inode_pkey;

ALTER TABLE inode DROP CONSTRAINT dir_name_parent_id_key;
ALTER TABLE inode DROP CONSTRAINT dir_parent_id_fkey;

DROP INDEX dir_parent_id_idx;

DROP RULE dir_remove ON inode;

CREATE TABLE dir (
	id BIGSERIAL,
	parent_id BIGINT,
	name TEXT,
	inode_id BIGSERIAL,
	PRIMARY KEY( id ),
	FOREIGN KEY( inode_id ) REFERENCES inode( id ),
	UNIQUE( name, parent_id )
);

CREATE INDEX dir_parent_id_idx ON dir( parent_id );

INSERT INTO dir SELECT id, parent_id, name, id AS inode_id FROM inode;

ALTER TABLE inode DROP COLUMN name;
ALTER TABLE inode DROP COLUMN parent_id;

ALTER TABLE data RENAME COLUMN dir_id TO inode_id;
ALTER INDEX data_dir_id_idx RENAME TO data_inode_id_idx;
ALTER TABLE data RENAME CONSTRAINT data_dir_id_fkey TO data_inode_id_fkey;

CREATE OR REPLACE RULE "inode_remove" AS ON
	DELETE TO inode WHERE OLD.mode & 16384 = 0
	DO ALSO DELETE FROM data WHERE inode_id=OLD.id;	
