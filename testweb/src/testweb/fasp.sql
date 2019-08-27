


select distinct REPAYMENT_TYPE from refund_histories@dlm.sfams_ro_link order by 1


select distinct REPAYMENT_TYPE from refund_histories@dlm.fasp_ro_link order by 1


select distinct REPAYMENT_TYPE from refund_histories@dlm.sfams_ro_link
minus
select distinct REPAYMENT_TYPE from refund_histories@dlm.fasp_ro_link


ADVANCE - APPLICANT
E LOAN (PAST YRS)
E.LOAN
ELOAN
ELOAN (PAST YRS)
LOAN 
TF GRANT - APPL
TF GRANT - APPLICANT




select distinct REPAYMENT_TYPE from refund_histories@dlm.fasp_ro_link
minus
select distinct REPAYMENT_TYPE from refund_histories@dlm.sfams_ro_link

LE_FR_TRY
NLS LOAN (PAST YRS)
NLS LOAN - TRY
NLS_FR_TRY


select distinct REPAYMENT_TYPE from refund_histories@dlm.sfams_ro_link
union
select distinct REPAYMENT_TYPE from refund_histories@dlm.fasp_ro_link


select * from REFUND_CASES@dlm.sfams_ro_link



select distinct payment_method from SFS_REP_TRANS_HISTORIES@dlm.sfams_ro_link 
union
select distinct payment_method from SFS_REP_TRANS_HISTORIES@dlm.fasp_ro_link 



select distinct payment_method from nls_REP_TRANS_HISTORIES@dlm.sfams_ro_link 
union
select distinct payment_method from nls_REP_TRANS_HISTORIES@dlm.fasp_ro_link 



select  count(0) from SFS_REP_PAYMENT_HISTS@dlm.fasp_ro_link order by transaction_timestamp desc
339588
select * from PAYMENT_Adj__HISTS@dlm.fasp_ro_link order by transaction_timestamp desc


select count(0) from payment_adj_hists@dlm.fasp_ro_link order by transaction_timestamp desc
1361955


select distinct pat_acct_type from SFS_REP_PAYMENT_HISTS@dlm.fasp_ro_link

select * from SFS_REP_PAYMENT_HISTS@dlm.sfams_ro_link 
select * from payment_adj_hists@dlm.sfams_ro_link 

select * from SFS_REP_PAYMENT_HISTS@dlm.fasp_ro_link  where sli_loan_ref_num = 'QV625452-5-01'
select * from payment_adj_hists@dlm.fasp_ro_link  where sli_loan_ref_num = 'QV625452-5-01'


select * from SFS_REP_PAYMENT_HISTS@dlm.fasp_ro_link

select sli_loan_ref_num, transaction_type, sum(amt) from SFS_REP_PAYMENT_HISTS@dlm.fasp_ro_link group by sli_loan_ref_num, transaction_type


select sli_loan_ref_num, transaction_type, sum(amt) from payment_adj_hists@dlm.fasp_ro_link group by sli_loan_ref_num, transaction_type
select  sli_loan_ref_num, sum(amt)  from refund_histories@dlm.fasp_ro_link group by sli_loan_ref_num


select * from refund_histories@dlm.fasp_ro_link


96098

select * from sfs_refund_histories@dlm.sfams_ro_link where ap_ai_hkid = 'Y5020067'



select * from SFS_REP_PAYMENT_HISTS@dlm.sfams_ro_link order by transaction_timestamp desc
select * from refund_histories@dlm.sfams_ro_link  order by transaction_timestamp desc
select * from payment_adj_hists@dlm.sfams_ro_link order by transaction_timestamp desc

select * from SFS_REP_PAYMENT_HISTS@dlm.fasp_ro_link order by transaction_timestamp desc
select * from refund_histories@dlm.fasp_ro_link  order by transaction_timestamp desc
select * from payment_adj_hists@dlm.fasp_ro_link order by transaction_timestamp desc