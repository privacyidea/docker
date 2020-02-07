#!/bin/bash
set -e

. bin/activate

echo "Starting development server.."

pi-manage runserver -h 0.0.0.0 -p 5000