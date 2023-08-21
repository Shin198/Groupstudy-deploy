using AutoMapper;
using DataLayer.DBObject;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using ServiceLayer.Interface;
using ShareResource.DTO.File;


namespace API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class DocumentFileController : ControllerBase
{
    private readonly IServiceWrapper _service;
    private readonly IMapper _mapper;

    //Path của thư mục chứa file
    private const string path = "D:\\UploadFile";

    // dòng này đổi thành host của máy
    private const string HostUploadFile = "http://192.168.1.5:8080/";

    public DocumentFileController(IServiceWrapper services, IMapper mapper)
    {
        this._service = services;
        this._mapper = mapper;
    }

    [HttpPost("/upload-file/{groupId}")]
    [DisableRequestSizeLimit]
    public async Task<ActionResult> UploadFile(IFormFile file, [FromRoute] int groupId, int accountId)
    {
        string httpFilePath = "";
        var documentFile = new DocumentFile();
        try
        {
            if (file.Length > 0)
            {
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }

                using (var fileStream = new FileStream(Path.Combine(path, file.FileName), FileMode.Create))
                {
                    await file.CopyToAsync(fileStream);
                    httpFilePath = HostUploadFile + file.FileName;
                }
            }

            if (!String.IsNullOrEmpty(httpFilePath))
            {
                documentFile.HttpLink = httpFilePath;
                documentFile.Approved = false;
                documentFile.AccountId = accountId;
                documentFile.GroupId = groupId;
                documentFile.CreatedDate = DateTime.Now;
                await _service.DocumentFiles.CreateDocumentFile(documentFile);
            }
        }
        catch (Exception ex)
        {
            throw new Exception("File Copy Failed", ex);
        }

        return Ok(documentFile);
    }

    
    [HttpGet("/get-list-file")]
    public async Task<ActionResult<DocumentFile>> GetListFile()
    {
        var result = _service.DocumentFiles.GetList();

        return Ok(result);
    }
    
   
    [HttpGet("/get-detail")]
    public async Task<ActionResult<DocumentFile>> GetFileDetail([FromQuery] int id)
    {
        var result = await _service.DocumentFiles.GetById(id);
        if (null == result)
        {
            return NotFound();
        }
        return Ok(result);
    }

 
    [HttpGet("/get-file-by-group")]
    public async Task<ActionResult<DocumentFile>> GetListFileByGroupId([FromQuery] int groupId, bool? approved)
    {
        var group = _service.Groups.GetFullByIdAsync(groupId).Result;
        if (null == group)
        {
            return NotFound();
        }
        var result = _service.DocumentFiles.GetListByGroupId(groupId, approved);
        List<DocumentFileDto> resultDto = new List<DocumentFileDto>();
        foreach (var documentFile in result)
        {
           var dto = _mapper.Map<DocumentFileDto>(documentFile);
           resultDto.Add(dto);
        }
        return Ok(resultDto);
    }

    [HttpPut("/accept-file")]
    public async Task<IActionResult> UpdateFile(int id, bool approved)
    {
        var file = _service.DocumentFiles.GetById(id).Result;
        if (null == file)
        {
            return NotFound();
        }

        if (approved)
        {
            file.Approved = approved;
            await _service.DocumentFiles.UpdateDocumentFile(file);
        }

        return Ok("approved");
    }

    [HttpDelete("/delete-file")]
    //chỗ này thêm Authen
    public async Task<IActionResult> DeleteFIle(int id)
    {
        var file = _service.DocumentFiles.GetById(id).Result;
        if (null == file)
        {
            return NotFound();
        }

        await _service.DocumentFiles.DeleteDocumentFile(id);
        return Ok("Deleted");
    }
    
    [HttpGet("/get-by-accountid")]
    //chỗ này thêm Authen
    public async Task<IActionResult> GetByAccountId([FromQuery] int accountId)
    {
        var account = await _service.Accounts.GetByIdAsync(accountId);
        if (null == account)
        {
            return NotFound();
        }
        var result = _service.DocumentFiles.GetListByAccountId(accountId);
        List<DocumentFileDto> resultDto = new List<DocumentFileDto>();
        foreach (var documentFile in result)
        {
            var dto = _mapper.Map<DocumentFileDto>(documentFile);
            resultDto.Add(dto);
        }
        return Ok(resultDto);
    }
}