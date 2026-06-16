USE CuaHangLapTop;
GO

-- =====================================================================
-- Fix FK MaLoai trong SanPham_Loai: them ON DELETE CASCADE
-- Hien tai FK nay khong co ON DELETE, nen xoa LoaiSP se bi loi vi pham.
-- Voi CASCADE: xoa 1 danh muc -> tu dong xoa hang trong SanPham_Loai
--              (SanPham van giu nguyen, chi mat lien ket voi danh muc do)
-- =====================================================================

-- Tim va xoa FK cu tren cot MaLoai
DECLARE @fkName NVARCHAR(200);
SELECT @fkName = fk.name
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
JOIN sys.tables  t  ON fk.parent_object_id   = t.object_id
JOIN sys.columns c  ON fkc.parent_object_id  = c.object_id
                   AND fkc.parent_column_id  = c.column_id
WHERE t.name = 'SanPham_Loai' AND c.name = 'MaLoai';

IF @fkName IS NOT NULL
    EXEC('ALTER TABLE SanPham_Loai DROP CONSTRAINT ' + @fkName);
GO

-- Tao lai FK voi ON DELETE CASCADE
ALTER TABLE SanPham_Loai
    ADD CONSTRAINT FK_SanPhamLoai_MaLoai
    FOREIGN KEY (MaLoai) REFERENCES LoaiSP(MaLoai) ON DELETE CASCADE;
GO

-- Kiem tra ket qua
SELECT
    fk.name AS TenFK,
    tp.name AS Bang,
    cp.name AS Cot,
    tr.name AS BangThamChieu,
    cr.name AS CotThamChieu,
    fk.delete_referential_action_desc AS OnDelete
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
JOIN sys.tables  tp ON fk.parent_object_id      = tp.object_id
JOIN sys.tables  tr ON fk.referenced_object_id  = tr.object_id
JOIN sys.columns cp ON fkc.parent_object_id     = cp.object_id AND fkc.parent_column_id    = cp.column_id
JOIN sys.columns cr ON fkc.referenced_object_id = cr.object_id AND fkc.referenced_column_id = cr.column_id
WHERE tp.name = 'SanPham_Loai';
GO

PRINT N'Fix FK ON DELETE CASCADE hoan tat!';
GO
