

select * from nls_loan_infos where loan_ref_num = 'EX957959-5-01'
46800	48346.6	0	0	3947	3947

select * from enls_rep_stat_fully_settled where loan_no = 'EX957959-5-01'

select * from enls_rep_stat_fully_settled where loan_no = 'EX957959-5-01'


select * from enls_rep_stat_fully_settled where ln_prcs_sts = 'P'


select LOAN_NO, ORIGINAL_PRINCIPAL, TOTAL_PRINCIPAL, ORIGINAL_STUDY_INTEREST, TOTAL_STUDY_INTEREST
from  enls_rep_stat_fully_settled

minus 

select loan_ref_num , ORIGINAL_PRINCIPAL, TOTAL_PRINCIPAL, ORIGINAL_STUDY_INTEREST, TOTAL_STUDY_INTEREST
from nls_loan_infos  where  loan_ref_num like 'E%'



select LOAN_NO, ORIGINAL_PRINCIPAL, TOTAL_PRINCIPAL
from  enls_rep_stat_fully_settled

minus 

select loan_ref_num , ORIGINAL_PRINCIPAL, TOTAL_PRINCIPAL
from nls_loan_infos  where  loan_ref_num like 'E%'






/////////////////////////



 
 0
 
 select orig_prcp from enls.LOAN where loan_no = 'EA801556-5-01'
 
 
  SELECT aa.loan_no, aa.orig_prcp - NVL(bb.setl_prcp, 0)
 FROM
       (SELECT l.loan_no, l.orig_prcp
        FROM enls.LOAN L
        WHERE l.lnpa_istu_insttu_cde = '01'
          AND l.lnpa_loan_typ = 'ENLS') aa,
        (SELECT loan_no, NVL( SUM( setl_prcp ), 0 )  setl_prcp
                  FROM enls.paym_log
                  WHERE insttu_cde = '01'
                    AND loan_typ = 'ENLS'
                    AND NVL( revse_ind, 'N' ) = 'N'
                    AND perd_no	= 0
                    GROUP BY loan_no) bb
  WHERE aa.loan_no = bb.loan_no (+)
 
 minus
 
 
 
 SELECT aa.loan_no, aa.paid_prcp - NVL(bb.setl_prcp, 0)
 FROM
       (SELECT a.loan_no, NVL( SUM( NVL( a.actl_paym_amt, loan_amt ) ) - NVL( SUM( a.refd_amt ), 0 ), 0 )  paid_prcp
          FROM enls.loan_entl a
          WHERE a.insttu_cde	= '01'
            AND a.loan_typ		= 'ENLS'
            AND a.paym_sts		= 'PA'
            AND NOT EXISTS  ( SELECT 'X' FROM enls.propsl
                                 WHERE lnpa_istu_insttu_cde           = a.insttu_cde
                                   AND lnpa_loan_typ                  = a.loan_typ
                                   AND appl_no                        = a.appl_no
                                   AND NVL( transfer_inout_ind, 'N' ) = 'O' )
        GROUP BY a.loan_no) aa,
        (SELECT loan_no, NVL( SUM( setl_prcp ), 0 )  setl_prcp
                  FROM enls.paym_log
                  WHERE insttu_cde = '01'
                    AND loan_typ = 'ENLS'
                    AND NVL( revse_ind, 'N' ) = 'N'
                    AND perd_no	= 0
                    GROUP BY loan_no) bb
  WHERE aa.loan_no = bb.loan_no (+)
  and aa.loan_no = 'EA105770-8-01'
  
          minus      
        select loan_ref_num,   TOTAL_PRINCIPAL
        from nls_loan_infos
        where loan_ref_num like 'E%'
        AND loan_ref_num = 'EA105770-8-01'
  

  EA105770-8-01	52300
EA108591-4-01	12500
EA144773-5-01	12500
  
  
  
  
  select LOAN_NO, ORIGINAL_PRINCIPAL
from  enls_rep_stat_fully_settled

minus

          select loan_ref_num,  ORIGINAL_PRINCIPAL
        from nls_loan_infos
        where loan_ref_num like 'E%'
        AND loan_ref_num = 'EX957959-5-01'
  
  
  
  SELECT a.loan_no, NVL( SUM( NVL( a.actl_paym_amt, loan_amt ) ) - NVL( SUM( a.refd_amt ), 0 ), 0 )  paid_prcp
          FROM enls.loan_entl a
          WHERE a.insttu_cde	= '01'
            AND a.loan_typ		= 'ENLS'
            AND a.paym_sts		= 'PA'
            and a.loan_no = 'EA467875-4-01'
            group by a.loan_no
    EA467875-4-01	10500        
            
             SELECT loan_no, NVL( SUM( setl_prcp ), 0 )  setl_prcp
                  FROM enls.paym_log
                  WHERE insttu_cde = '01'
                    AND loan_typ = 'ENLS'
                    AND NVL( revse_ind, 'N' ) = 'N'
                    AND perd_no	= 0
                    and loan_no = 'EA467875-4-01'
                    GROUP BY loan_no
                    
      EA467875-4-01	10500              
      
      
      select * from nls_loan_infos where loan_ref_num = 'EA467875-4-01'
      
      
      
           SELECT l.loan_no, l.orig_prcp
        FROM enls.LOAN L
        
        minus
        
        select loan_ref_num, ORIGINAL_PRINCIPAL
        from nls_loan_infos
        where loan_ref_num like 'E%'
        
         minus
         
                   SELECT l.loan_no, l.orig_prcp
        FROM enls.LOAN L
        