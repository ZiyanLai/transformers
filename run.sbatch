#!/bin/bash
#SBATCH --gres=gpu:1
#SBATCH --mem=16000
#SBATCH --time=3:30:00
#SBATCH --job-name="nlp project"
#SBATCH --output=log.txt
module purge
module load anaconda3/5.3.1
module load cuda/10.0.130
module load gcc/6.3.0

# Replace with your NetID
NETID=zl1532
source activate /scratch/${NETID}/nlu/env

cd /scratch/${NETID}/nlu/code/transformers
export PYTHONPATH=/scratch/${NETID}/nlu/code/transformers/src:$PYTHONPATH
TASK_NAME=Abuse
python ./examples/run_glue.py\
    --model_type bert\
    --model_name_or_path bert-base-uncased\
    --task_name ${TASK_NAME}\
    --do_train\
    --do_eval\
    --max_seq_length 128\
    --per_gpu_train_batch_size=8\
    --per_gpu_eval_batch_size=8\
    --data_dir /scratch/${NETID}/nlu/data/${TASK_NAME}\
    --do_lower_case\
    --learning_rate 2e-8\
    --num_train_epochs 1.0\
    --output_dir /scratch/${NETID}/nlu/${TASK_NAME}_run/
    
