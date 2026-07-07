Add-Type -AssemblyName System.Drawing

$assets = Join-Path (Split-Path -Parent $PSScriptRoot) 'assets'

$cards = @(
  @{
    File = 'og-matematicas.png'
    Area = "Matem$([char]0x00E1)ticas"
    Title = 'Aprende con fundamentos'
    Subtitle = "Aritm$([char]0x00E9)tica, $([char]0x00C1)lgebra y C$([char]0x00E1)lculo explicados paso a paso"
    Accent = [System.Drawing.Color]::FromArgb(185, 7, 38)
    Symbol = 'M'
  },
  @{
    File = 'og-fisica.png'
    Area = "F$([char]0x00ED)sica"
    Title = 'Entiende antes de memorizar'
    Subtitle = 'Conceptos, unidades y problemas explicados con claridad'
    Accent = [System.Drawing.Color]::FromArgb(0, 140, 150)
    Symbol = 'F'
  },
  @{
    File = 'og-quimica.png'
    Area = "Qu$([char]0x00ED)mica"
    Title = 'Comprende lo que ocurre'
    Subtitle = 'Reacciones, sustancias y conceptos explicados paso a paso'
    Accent = [System.Drawing.Color]::FromArgb(74, 32, 56)
    Symbol = 'Q'
  },
  @{
    File = 'og-biologia.png'
    Area = "Biolog$([char]0x00ED)a"
    Title = 'Aprende ciencia con sentido'
    Subtitle = "C$([char]0x00E9)lulas, vida y procesos explicados con claridad"
    Accent = [System.Drawing.Color]::FromArgb(14, 58, 54)
    Symbol = 'B'
  },
  @{
    File = 'og-ingles.png'
    Area = "Ingl$([char]0x00E9)s"
    Title = "Aprende ingl$([char]0x00E9)s con estructura"
    Subtitle = "Gram$([char]0x00E1)tica y frases explicadas sin traducir palabra por palabra"
    Accent = [System.Drawing.Color]::FromArgb(217, 151, 32)
    Symbol = 'EN'
  }
)

$fontTitle = New-Object System.Drawing.Font('Arial', 50, [System.Drawing.FontStyle]::Bold)
$fontArea = New-Object System.Drawing.Font('Arial', 28, [System.Drawing.FontStyle]::Bold)
$fontSubtitle = New-Object System.Drawing.Font('Arial', 27, [System.Drawing.FontStyle]::Regular)
$fontBrand = New-Object System.Drawing.Font('Arial', 28, [System.Drawing.FontStyle]::Bold)
$fontSymbol = New-Object System.Drawing.Font('Arial', 112, [System.Drawing.FontStyle]::Bold)

foreach ($card in $cards) {
  $bmp = New-Object System.Drawing.Bitmap(1200, 630)
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

  $bg = [System.Drawing.Color]::FromArgb(255, 253, 247)
  $ink = [System.Drawing.Color]::FromArgb(22, 24, 39)
  $muted = [System.Drawing.Color]::FromArgb(92, 96, 112)
  $line = [System.Drawing.Color]::FromArgb(222, 216, 200)

  $g.Clear($bg)

  $gridPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(28, 22, 24, 39), 1)
  for ($x = 0; $x -le 1200; $x += 44) { $g.DrawLine($gridPen, $x, 0, $x, 630) }
  for ($y = 0; $y -le 630; $y += 44) { $g.DrawLine($gridPen, 0, $y, 1200, $y) }

  $accentBrush = New-Object System.Drawing.SolidBrush($card.Accent)
  $inkBrush = New-Object System.Drawing.SolidBrush($ink)
  $mutedBrush = New-Object System.Drawing.SolidBrush($muted)
  $whiteBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
  $panelBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(250, 255, 250, 240))
  $panelPen = New-Object System.Drawing.Pen($line, 2)

  $g.FillRectangle($panelBrush, 72, 72, 1056, 486)
  $g.DrawRectangle($panelPen, 72, 72, 1056, 486)
  $g.FillRectangle($accentBrush, 72, 72, 14, 486)
  $g.FillEllipse($accentBrush, 856, 118, 190, 190)

  $sfCenter = New-Object System.Drawing.StringFormat
  $sfCenter.Alignment = [System.Drawing.StringAlignment]::Center
  $sfCenter.LineAlignment = [System.Drawing.StringAlignment]::Center
  $g.DrawString($card.Symbol, $fontSymbol, $whiteBrush, [System.Drawing.RectangleF]::new(856, 118, 190, 190), $sfCenter)

  $g.DrawString($card.Area.ToUpperInvariant(), $fontArea, $accentBrush, 128, 128)
  $g.DrawString($card.Title, $fontTitle, $inkBrush, [System.Drawing.RectangleF]::new(124, 186, 700, 176))
  $g.DrawString($card.Subtitle, $fontSubtitle, $mutedBrush, [System.Drawing.RectangleF]::new(128, 370, 760, 96))

  $accentPen = New-Object System.Drawing.Pen($card.Accent, 5)
  $g.DrawLine($accentPen, 128, 488, 360, 488)
  $g.DrawString('EtaGebra', $fontBrand, $inkBrush, 128, 510)
  $g.DrawString('Academia de ciencias', $fontSubtitle, $mutedBrush, 330, 513)

  $out = Join-Path $assets $card.File
  $bmp.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)
  $g.Dispose()
  $bmp.Dispose()
  Write-Host "written $out"
}
