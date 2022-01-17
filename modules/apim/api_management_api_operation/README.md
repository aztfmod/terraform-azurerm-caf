module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# api_management_api_operation

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|operation_id| A unique identifier for this API Operation. Changing this forces a new resource to be created.||True|
|api_name| The name of the API within the API Management Service where this API Operation should be created. Changing this forces a new resource to be created.||True|
|api_management|The `api_management` block as defined below.|Block|True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|display_name| The Display Name for this API Management Operation.||True|
|method| The HTTP Method used for this API Management Operation, like `GET`, `DELETE`, `PUT` or `POST` - but not limited to these values.||True|
|url_template| The relative URL Template identifying the target resource for this operation, which may include parameters.||True|
|description| A description for this API Operation, which may include HTML formatting tags.||False|
|request| A `request` block as defined below.| Block |False|
|response| One or more `response` blocks as defined below.| Block |False|
|template_parameter| One or more `template_parameter` blocks as defined below.| Block |False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|api_management| key | Key for  api_management||| Required if  |
|api_management| lz_key |Landing Zone Key in wich the api_management is located|||True|
|api_management| name | The name of the api_management |||True|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|request|description| A description of the HTTP Request, which may include HTML tags.|||True|
|request|header| One or more `header` blocks as defined above.|||False|
|header|name| The Name of this Header.|||True|
|header|required| Is this Header Required?|||True|
|header|type| The Type of this Header, such as a `string`.|||True|
|header|description| A description of this Header.|||False|
|header|default_value| The default value for this Header.|||False|
|header|values| One or more acceptable values for this Header.|||False|
|request|query_parameter| One or more `query_parameter` blocks as defined above.|||False|
|query_parameter|name| The Name of this Query Parameter.|||True|
|query_parameter|required| Is this Query Parameter Required?|||True|
|query_parameter|type| The Type of this Query Parameter, such as a `string`.|||True|
|query_parameter|description| A description of this Query Parameter.|||False|
|query_parameter|default_value| The default value for this Query Parameter.|||False|
|query_parameter|values| One or more acceptable values for this Query Parameter.|||False|
|request|representation| One or more `representation` blocks as defined below.|||False|
|representation|content_type| The Content Type of this representation, such as `application/json`.|||True|
|representation|form_parameter| One or more `form_parameter` block as defined above.|||False|
|form_parameter|name| The Name of this Form Parameter.|||True|
|form_parameter|required| Is this Form Parameter Required?|||True|
|form_parameter|type| The Type of this Form Parameter, such as a `string`.|||True|
|form_parameter|description| A description of this Form Parameter.|||False|
|form_parameter|default_value| The default value for this Form Parameter.|||False|
|form_parameter|values| One or more acceptable values for this Form Parameter.|||False|
|representation|example| One or more `example` blocks as defined above.|||False|
|example|name| The name of this example.|||True|
|example|summary| A short description for this example.|||False|
|example|description| A long description for this example.|||False|
|example|value| The example of the representation.|||False|
|example|external_value| A URL that points to the literal example.|||False|
|representation|sample| An example of this representation.|||False|
|representation|sample| An example of this representation.|||False|
|representation|schema_id| The ID of an API Management Schema which represents this Response.|||False|
|representation|type_name| The Type Name defined by the Schema.|||False|
|response|status_code| The HTTP Status Code.|||True|
|response|description| A description of the HTTP Response, which may include HTML tags.|||True|
|response|header| One or more `header` blocks as defined above.|||False|
|header|name| The Name of this Header.|||True|
|header|required| Is this Header Required?|||True|
|header|type| The Type of this Header, such as a `string`.|||True|
|header|description| A description of this Header.|||False|
|header|default_value| The default value for this Header.|||False|
|header|values| One or more acceptable values for this Header.|||False|
|response|representation| One or more `representation` blocks as defined below.|||False|
|representation|content_type| The Content Type of this representation, such as `application/json`.|||True|
|representation|form_parameter| One or more `form_parameter` block as defined above.|||False|
|form_parameter|name| The Name of this Form Parameter.|||True|
|form_parameter|required| Is this Form Parameter Required?|||True|
|form_parameter|type| The Type of this Form Parameter, such as a `string`.|||True|
|form_parameter|description| A description of this Form Parameter.|||False|
|form_parameter|default_value| The default value for this Form Parameter.|||False|
|form_parameter|values| One or more acceptable values for this Form Parameter.|||False|
|representation|example| One or more `example` blocks as defined above.|||False|
|example|name| The name of this example.|||True|
|example|summary| A short description for this example.|||False|
|example|description| A long description for this example.|||False|
|example|value| The example of the representation.|||False|
|example|external_value| A URL that points to the literal example.|||False|
|representation|sample| An example of this representation.|||False|
|representation|sample| An example of this representation.|||False|
|representation|schema_id| The ID of an API Management Schema which represents this Response.|||False|
|representation|type_name| The Type Name defined by the Schema.|||False|
|template_parameter|name| The Name of this Template Parameter.|||True|
|template_parameter|required| Is this Template Parameter Required?|||True|
|template_parameter|type| The Type of this Template Parameter, such as a `string`.|||True|
|template_parameter|description| A description of this Template Parameter.|||False|
|template_parameter|default_value| The default value for this Template Parameter.|||False|
|template_parameter|values| One or more acceptable values for this Template Parameter.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the API Management API Operation.|||
