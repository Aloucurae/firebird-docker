# docker Firebird

Baseado na imagem do Firebird [jacobalberty/firebird
](https://hub.docker.com/r/jacobalberty/firebird)

Versao disponoverl:

<p><a href="https://github.com/Aloucurae/firebird-docker/Dockerfile" rel="nofollow noopener"> <code>v3.0</code>  (<em>Dockerfile</em>)</a></p>

<h2>Description</h2>
<p>This is a Firebird SQL Database container.</p>
<h2>Default Login information</h2>
<p>Username: SYSDBA
Password is either set by <code>ISC_PASSWORD</code> or randomized</p>
<h2>Environment Variables:</h2>

<h3><code>TZ</code></h3>
<p>TimeZone. (i.e. America/Chicago)</p>

<h3><code>FIREBIRD_ALIASES </code></h3>
<p>MYDB=/some/long/directory;MYOTHERDB=/some/other/long/directory</p>
<p>MYDB=/some/long/directory;MYOTHERDB=/some/other/long/directory</p>


<h3><code>ISC_PASSWORD</code></h3>
<p>Default <code>sysdba</code> user password, if left blank a random 20 character password will be set instead.
The password used will be placed in <code>/firebird/etc/SYSDBA.password</code>.
If a random password is generated then it will be in the log for the container.</p>

<h3><code>FIREBIRD_DATABASE</code></h3>
<p>If this is set then a database will be created with this name under the <code>/firebird/data</code> volume with the 'UTF8'
default character set and if <code>FIREBIRD_USER</code> is also set then <code>FIREBIRD_USER</code> will be given ownership.</p>

<h3><code>FIREBIRD_USER</code></h3>
<p>This user will be created and given ownership of <code>FIREBIRD_DATABASE</code>.
This variable is only used if <code>FIREBIRD_DATABASE</code> is also set.</p>

<h3><code>FIREBIRD_PASSWORD</code></h3>
<p>The password for <code>FIREBIRD_USER</code>, if left blank a random 20 character password will be set instead.
If a random password is generated then it will be in the log for the container.</p>

<h3><code>EnableLegacyClientAuth</code></h3>
<p>If this is set to true then when launching without an existing /firebird/etc folder this will cause the newly created firebird.conf to have
the following defaults:</p>
<pre><code>AuthServer = Legacy_Auth, Srp, Win_Sspi
AuthClient = Legacy_Auth, Srp, Win_Sspi
UserManager = Legacy_UserManager, Srp
WireCrypt = enabled
</code></pre>
<p>This will allow legacy clients to connect and authenticate.</p>

<h3><code>DataTypeCompatibility</code></h3>
<p>If this is set then when launching without an existing /firebird/etc folder this will cause the newly created firebird.conf to set <code>DataTypeCompatibility</code> with the defined value supported by Firebird.</p>
<pre><code># ----------------------------
# Engine currently provides a number of new datatypes unknown to legacy clients.
# In order to simplify use of old applications set this parameter to minor FB
# version datatype compatibility with which you need. Currently two values are
# supported: 3.0 &amp; 2.5.
# More precise (including per-session) tuning is possible via SQL and DPB.
#
# Per-database configurable.
#
#    Type: string
#
# DataTypeCompatibility =
</code></pre>

<h3><code>EnableWireCrypt</code></h3>
<p>If this is set to true then when launching without an existing /firebird/etc folder this will cause the newly created firebird.conf to have
<code>WireCrypt = enabled</code> to allow compatibility with Jaybird 3</p>

<h3><code>&lt;VARIABLE&gt;_FILE</code></h3>
<p>If set to the path to a file then the named variable minus the_FILE portion will contain the contents of that file.
This is useful for using docker secrets to manage your password.
This applies to all variables except <code>TZ</code></p>

<h2>Volumes:</h2>

<h3><code>/firebird</code></h3>
<p>This single volume supercedes all of the old volumes with most of the old volumes existing as subdirectories under <code>/firebird</code></p>
<h4><code>/firebird/data</code></h4>
<p>Default location to put database files</p>
<h4><code>/firebird/restore</code></h4>
<p>Any <code>.fbk</code> files located in here that do not have a matching <code>.fdb</code> file under <code>/firebird/data</code> will automatically be restored via <code>gbak</code> to <code>/firebird/data</code> on container start.
The function that handles restoration starts by looking for <code>/firebird/etc/SYSDBA.password</code> if the file doesn't exist then no restoration attempts will be made.
If that file exists then it will check for a <code>.env</code> file matching the <code>.fbk</code> file in <code>/firebird/restore</code> and attempt to load <code>RESTORE_USER</code> and <code>RESTORE_PASSWORD</code> from that file but will fall back to <code>ISC_USER</code> and <code>ISC_PASSWORD</code> from <code>/firebird/etc/SYSDBA.password</code> if those values do not exist in the <code>.env</code> file or the <code>.env</code> file is missing.</p>
<p>So for example if you have <code>/firebird/restore/database.fbk</code> the script will first check if <code>/firebird/etc/SYSDBA.password</code> exists and fail if it doesn't. It will then check if <code>/firebird/data/database.fdb</code> exists. If that file does not exist the script will then attempt to restore <code>/firebird/restore/database.fbk</code> to <code>/firebird/data/database.fdb</code> using either <code>RESTORE_USER</code> and <code>RESTORE_PASSWORD</code> from <code>/firebird/restore/database.env</code> or if that file does not exist it will use <code>ISC_USER</code> and <code>ISC_PASSWORD</code> from  <code>/firebird/etc/SYSDBA.password</code>.</p>
<h4><code>/firebird/system</code></h4>
<p>security database DIR</p>
<h4><code>/firebird/etc</code></h4>
<p>config files DIR
message files DIR</p>
<h4><code>/firebird/log</code></h4>
<p>log files DIR</p>

<h3>Read Only root filesystem</h3>
<p>For some users they may prefer to run the filesystem in read only mode for additional security.
These volumes would need to be created rw in order to do this.</p>
<h4><code>/var/firebird/run</code></h4>
<p>This volume does not actually exist by default but you may want to create it if you wish to use a <code>read only</code> root filesystem
guardian lock DIR</p>
<h4><code>/tmp</code></h4>
<p>This volume does not actually exist by default but you may want to create it if you wish to use a <code>read only</code> root filesystem
Database lock directory</p>
<h2>Exposes:</h2>

<h3>3050/tcp</h3>

[more info](https://hub.docker.com/r/jacobalberty/firebird)
