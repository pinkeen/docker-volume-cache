Docker Volume Cache (Sync)
==========================

Docker image for syncing two docker volume contents to create a cache for slow 
networked mounts (osxfs/nfs).

In principle it is almost exactly the same as [`docker-bg-sync`](https://github.com/cweagans/docker-bg-sync)
which I have discovered after the fact, however, it uses two containers
(based on the same image) to ensure permissions (uid/gid) are always guaranteed
to be proper on both sides.

The image is published to docker hub as `pink33n/docker-volume-sync`.

# Example

See [`docker-compose.yml`](docker-compose.yml) for a usage example.

# How it works

Each container runs unison as it's mount owner (uid/gid) with `sudo`.
This is specified `SYNC_UID` and `SYNC_GID` env vars, however, the only
was to guarantee it can always access the files is to actually start 
the container as the mount user instead of setting these variables.

The container can be ran in two modes:
- Server mode - starts a unison listener as the target user.
- Client mode - connects to the server and actually initiates the sync.

# How to run it

Start two containers for each volume, mounted at `/dvs/data` - one in
client mode - with `SYNC_SERVER_HOST` defined as the host address of 
the second server mode container.

---

The client container should have the *host* (networked) volume mounted as 
it performs the actual sync and is always the preferred source of truth
(`prefer` unison option).

Usually the containers should be started as the user (UID:GID) that owns
the files in the volume. Alternatively you can specify the pair via env vars
and the entrypoint will switch to this user (container user must be root for this).
The second option might introduce problems with permissions / access and should
be used only when you're sure the actual contents will be always owned by this uids.

For more configuration options see the *default* (overridable) env vars defined
in [`entrypoint`](entrypoint).



