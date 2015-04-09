-- Para lanzar este script ejecutar lo siguiente:
-- db2cmd
-- db2 connect to <nombre-bd> user <usuario> using <clave>
-- db2 -td@ -vf 07.archivo-create-procedures-db2.sql
-- db2 terminate

CREATE PROCEDURE UPDATECODREF ( IN ROOT VARCHAR(32), SEPARATOR VARCHAR(1), UPDTABLES VARCHAR(1) )
BEGIN ATOMIC

	-- Este procedimiento requiere que se establezca el idpadre antes de llamar
	-- para actualizar los c�digos de referencia y el resto de campos

	IF (ROOT IS NOT NULL) THEN
		FOR ELEMENTO AS
			SELECT TIPO FROM ASGFELEMENTOCF WHERE ID=ROOT
		DO

			IF (TIPO IS NOT NULL) THEN
				IF ((TIPO IN (2,3,4,5,6)) AND (UPDTABLES='S')) THEN
					FOR FONDO AS
						WITH CTE_ELEMENTOS (ID, IDPADRE, TIPO, CODREFERENCIA) AS
						(
							SELECT ID, IDPADRE, TIPO, CODREFERENCIA FROM ASGFELEMENTOCF WHERE ID = ROOT
							UNION ALL
							SELECT A.ID, A.IDPADRE, A.TIPO, A.CODREFERENCIA FROM ASGFELEMENTOCF A, CTE_ELEMENTOS CTE
							WHERE A.ID = CTE.IDPADRE
						)
						SELECT CTE.ID IDFONDO_CALCULADO, GETCODREF(CTE.ID,SEPARATOR) CODREFERENCIAFONDO_CALCULADO
						FROM CTE_ELEMENTOS CTE
						WHERE CTE.TIPO=2
					DO
						-- Actualizar el idfondo a todos sus hijos
						UPDATE ASGFELEMENTOCF SET IDFONDO=IDFONDO_CALCULADO WHERE ID IN (SELECT ID FROM TABLE(GETHIJOSELEMENTO(ROOT)) AS HIJOS);

						-- Actualizar el idfondo a todas sus series
						UPDATE ASGFSERIE SET IDFONDO=IDFONDO_CALCULADO WHERE IDELEMENTOCF IN (SELECT ID FROM TABLE(GETHIJOSELEMENTO(ROOT)) AS HIJOS WHERE HIJOS.TIPO=4);

						-- Actualizar el idfondo a todas las unidades documentales
						UPDATE ASGFUNIDADDOC SET IDFONDO=IDFONDO_CALCULADO WHERE IDELEMENTOCF IN (SELECT ID FROM TABLE(GETHIJOSELEMENTO(ROOT)) AS HIJOS WHERE HIJOS.TIPO=6);

						-- Actualizar la identificacion a todas las unidades documentales
						UPDATE ASGDUDOCENUI SET IDENTIFICACION=CODREFERENCIAFONDO_CALCULADO || '-' || SIGNATURAUDOC WHERE IDUNIDADDOC IN (SELECT ID FROM TABLE(GETHIJOSELEMENTO(ROOT)) AS HIJOS WHERE HIJOS.TIPO=6);

						-- Actualizar la identificacion de las unidades de instalaci�n
						UPDATE ASGDUINSTALACION SET IDENTIFICACION=CODREFERENCIAFONDO_CALCULADO || '.' || SIGNATURAUI WHERE ID IN (SELECT ASGDUDOCENUI.IDUINSTALACION FROM ASGDUDOCENUI ASGDUDOCENUI, TABLE(GETHIJOSELEMENTO(ROOT)) AS HIJOS WHERE HIJOS.TIPO=6 AND HIJOS.ID=ASGDUDOCENUI.IDUNIDADDOC);
					END FOR;
				END IF;

				IF ((TIPO IN (6)) AND (UPDTABLES='S')) THEN
					FOR SERIE AS
						WITH CTE_ELEMENTOS (ID, IDPADRE, TIPO) AS
						(
							SELECT ID, IDPADRE, TIPO FROM ASGFELEMENTOCF WHERE ID = ROOT
							UNION ALL
							SELECT A.ID, A.IDPADRE, A.TIPO FROM ASGFELEMENTOCF A, CTE_ELEMENTOS CTE
							WHERE A.ID = CTE.IDPADRE
						)
						SELECT CTE.ID IDSERIE_CALCULADO
						FROM CTE_ELEMENTOS CTE
						WHERE CTE.TIPO=4
					DO
						UPDATE ASGFUNIDADDOC SET IDSERIE=IDSERIE_CALCULADO WHERE IDELEMENTOCF IN (SELECT ID FROM TABLE(GETHIJOSELEMENTO(ROOT)) AS HIJOS WHERE HIJOS.TIPO=6);
					END FOR;
				END IF;

				FOR ELEMENTOS_NOSERIE AS
					WITH CTE_ELEMENTOS (ID, TIPO, CODIGO, IDPADRE) AS
					(
						SELECT ID, TIPO, CODIGO, IDPADRE FROM ASGFELEMENTOCF WHERE ID = ROOT
						UNION ALL
						SELECT A.ID, A.TIPO, A.CODIGO, A.IDPADRE FROM ASGFELEMENTOCF A, CTE_ELEMENTOS CTE
						WHERE A.IDPADRE = CTE.ID
					)
					SELECT ID IDELEMENTO, TIPO, CODIGO, IDPADRE FROM CTE_ELEMENTOS
					WHERE TIPO NOT IN (4,6)
				DO

					FOR CODSREF AS
						SELECT COALESCE(GETCODREF(IDFONDO, SEPARATOR),NULLIF('1','1')) CODREFFONDO_CALCULADO,
						GETCODREF(IDELEMENTO, SEPARATOR) CODREFERENCIA_CALCULADO,
						GETFINCODREFPADRE(IDELEMENTO, SEPARATOR) FINALCODREFPADRE_CALCULADO
						FROM ASGFELEMENTOCF WHERE ID=IDELEMENTO
					DO
						UPDATE ASGFELEMENTOCF SET CODREFFONDO=CODREFFONDO_CALCULADO, CODREFERENCIA=CODREFERENCIA_CALCULADO, FINALCODREFPADRE=FINALCODREFPADRE_CALCULADO WHERE ID=IDELEMENTO;
					END FOR;
				END FOR;
				FOR ELEMENTOS_SERIE AS
					WITH CTE_ELEMENTOS (ID, TIPO, CODIGO, IDPADRE) AS
					(
						SELECT ID, TIPO, CODIGO, IDPADRE FROM ASGFELEMENTOCF WHERE ID = ROOT
						UNION ALL
						SELECT A.ID, A.TIPO, A.CODIGO, A.IDPADRE FROM ASGFELEMENTOCF A, CTE_ELEMENTOS CTE
						WHERE A.IDPADRE = CTE.ID
					)
					SELECT ID IDELEMENTO, TIPO, CODIGO, IDPADRE FROM CTE_ELEMENTOS
					WHERE TIPO=4
				DO

					FOR CODSREF AS
						SELECT COALESCE(GETCODREF(IDFONDO, SEPARATOR),NULLIF('1','1')) CODREFFONDO_CALCULADO,
						GETCODREF(IDELEMENTO, SEPARATOR) CODREFERENCIA_CALCULADO,
						GETFINCODREFPADRE(IDELEMENTO, SEPARATOR) FINALCODREFPADRE_CALCULADO
						FROM ASGFELEMENTOCF WHERE ID=IDELEMENTO
					DO
						UPDATE ASGFELEMENTOCF SET CODREFFONDO=CODREFFONDO_CALCULADO, CODREFERENCIA=CODREFERENCIA_CALCULADO, FINALCODREFPADRE=FINALCODREFPADRE_CALCULADO WHERE ID=IDELEMENTO;
						UPDATE ASGFELEMENTOCF SET CODREFFONDO=CODREFFONDO_CALCULADO, CODREFERENCIA=CODREFERENCIA_CALCULADO || SEPARATOR || CODIGO, FINALCODREFPADRE=NULL WHERE IDPADRE=IDELEMENTO;
					END FOR;
				END FOR;
			END IF;
		END FOR;
	END IF;
END
@