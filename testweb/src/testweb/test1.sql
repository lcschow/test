SELECT (a.account_count + b.account_count + d.account_count) AS loan_cnt,
       ROUND((a.undemanded_principal + NVL(c.principal_arrear, 0) + NVL(d.principal_arrear, 0) + NVL(e.principal_arrear, 0))/1000000, 3) AS outstanding_principal
FROM (SELECT COUNT(loan_ref_num) account_count,
			SUM(undemanded_principal) undemanded_principal
		FROM fasp_rep_stat_loan
		WHERE loan_status = 'R'	
		AND grant_loan_flag IN ('G', 'L', 'Q')
		AND original_principal > 0
		AND undemanded_principal > 0
		AND scheme_code = 'FASP'
		AND position_date = P_POSITION_DATE) a,
	(SELECT COUNT(aa.loan_ref_num) account_count
		FROM fasp_rep_stat_loan aa,
				(SELECT loan_ref_num, 
						MAX(instal_num) last_instal_num
				FROM fasp_rep_stat_loan_rep
				WHERE scheme_code = 'FASP'
				AND position_date = P_POSITION_DATE
				AND loan_status  = 'R'
				AND demand_note_type = 'N'
				AND instal_principal_unpaid > 0
				GROUP BY loan_ref_num) bb
		WHERE aa.loan_ref_num = bb.loan_ref_num
		AND aa.total_instal_num = bb.last_instal_num
		AND aa.scheme_code = 'FASP'
		AND aa.position_date = P_POSITION_DATE
		AND aa.loan_status  = 'R'
		AND aa.original_principal > 0
		AND aa.undemanded_principal = 0) b,
	(SELECT SUM(instal_principal_unpaid) principal_arrear
		FROM fasp_rep_stat_loan_rep
		WHERE scheme_code = 'FASP'
		AND position_date = P_POSITION_DATE
		AND loan_status = 'R'
		AND demand_note_type = 'N'
		AND total_principal > 0) c,	
    (SELECT COUNT(DISTINCT loan_ref_num) account_count,
			SUM(instal_principal_unpaid) principal_arrear
    FROM fasp_rep_stat_loan_rep
    WHERE scheme_code = 'FASP'
    AND position_date = P_POSITION_DATE
    AND loan_status = 'R'
    AND demand_note_type = 'F'
    AND undemanded_principal = 0
    AND instal_principal_unpaid > 0
    AND loan_ref_num NOT IN (SELECT aa.loan_ref_num
            FROM fasp_rep_stat_loan aa
            WHERE aa.scheme_code = 'FASP'
            AND aa.position_date = P_POSITION_DATE
            AND aa.loan_status = 'R'
            AND aa.original_principal > 0
			AND aa.undemanded_principal = 0
            AND EXISTS (SELECT 1
                FROM fasp_rep_stat_loan_rep cc
                WHERE cc.scheme_code = aa.scheme_code 
                AND cc.position_date = aa.position_date
                AND cc.loan_status = aa.loan_status
                AND cc.loan_ref_num = aa.loan_ref_num
                AND cc.instal_num = aa.total_instal_num
                AND cc.demand_note_type = 'N'
                AND cc.instal_principal_unpaid = 0))) d,
    (SELECT SUM(instal_principal_unpaid) principal_arrear
		FROM fasp_rep_stat_loan_rep
		WHERE scheme_code = 'FASP'
		AND position_date = P_POSITION_DATE
		AND loan_status = 'R'
		AND demand_note_type = 'F'
		AND undemanded_principal > 0
		AND instal_principal_unpaid > 0) e