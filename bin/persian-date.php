<?php
$formatter = IntlDateFormatter::create("en_US", NULL, NULL, "Asia/Tehran");

$formatter->setCalendar(IntlCalendar::createInstance("Asia/Tehran", "pt_PT@calendar=persian"));
$formatter->setPattern("Y-M-d E");
echo $formatter->format(time());
